import hashlib
import json
import re
import subprocess
from pathlib import Path
from urllib.request import urlopen


REPO = "GOODBOY008/labelize-studio"
CASK = Path(__file__).resolve().parents[1] / "Casks" / "labelize-studio.rb"
VERSION = r"(?:0|[1-9][0-9]*)\.(?:0|[1-9][0-9]*)\.(?:0|[1-9][0-9]*)"
SHA256 = r"[0-9a-f]{64}"
CASK_RELEASE = re.compile(
    rf'^  version "(?P<version>{VERSION})"\n'
    rf'  sha256 arm:   "(?P<arm>{SHA256})",\n'
    rf'         intel: "(?P<intel>{SHA256})"$',
    re.MULTILINE,
)


def version_key(version):
    return tuple(map(int, version.split(".")))


def latest_release():
    pages = json.loads(subprocess.check_output([
        "gh", "api", "--paginate", "--slurp", f"repos/{REPO}/releases?per_page=100",
    ]))
    releases = [
        release for page in pages for release in page
        if not release["draft"] and not release["prerelease"] and re.fullmatch(f"v{VERSION}", release["tag_name"])
    ]
    if not releases:
        raise ValueError(f"No published vX.Y.Z release found in {REPO}")
    return max(releases, key=lambda release: version_key(release["tag_name"][1:]))


def asset_hash(assets, name):
    asset = assets.get(name, {})
    digest = re.fullmatch(rf"sha256:({SHA256})", asset.get("digest") or "")
    if asset.get("state") != "uploaded" or not digest:
        raise ValueError(f"Missing uploaded asset or SHA-256 digest for {name}")
    return digest[1]


def package_hashes(release, version):
    assets = {asset["name"]: asset for asset in release["assets"]}
    manifest_hash = asset_hash(assets, "SHA256SUMS")
    url = f"https://github.com/{REPO}/releases/download/v{version}/SHA256SUMS"
    with urlopen(url, timeout=30) as response:
        manifest = response.read(64 * 1024)
    if hashlib.sha256(manifest).hexdigest() != manifest_hash:
        raise ValueError(f"SHA256SUMS digest mismatch for v{version}")

    checksums = {}
    for line in manifest.decode("utf-8").splitlines():
        digest, name = line.split(maxsplit=1)
        name = name.removeprefix("*")
        if name in checksums or not re.fullmatch(SHA256, digest):
            raise ValueError(f"Invalid SHA256SUMS entry for {name}")
        checksums[name] = digest

    hashes = []
    for arch in ("arm64", "x86_64"):
        name = f"LabelizeStudio-{version}-macos-{arch}-release.pkg"
        digest = asset_hash(assets, name)
        if checksums.get(name) != digest:
            raise ValueError(f"SHA256SUMS disagrees with the release asset digest for {name}")
        hashes.append(digest)
    return hashes


def sync_cask():
    source = CASK.read_text(encoding="utf-8")
    current = CASK_RELEASE.search(source)
    if not current:
        raise ValueError("Could not find the version and both architecture hashes in the cask")

    release = latest_release()
    version = release["tag_name"][1:]
    if version_key(version) < version_key(current["version"]):
        raise ValueError(f"Published v{version} is older than cask v{current['version']}")
    arm, intel = package_hashes(release, version)
    if version == current["version"]:
        if (arm, intel) != (current["arm"], current["intel"]):
            raise ValueError(f"The assets for v{version} changed. Publish them under a new version.")
        print(f"The cask is already in sync with v{version}.")
        return

    updated = f'  version "{version}"\n  sha256 arm:   "{arm}",\n         intel: "{intel}"'
    CASK.write_text(source[:current.start()] + updated + source[current.end():], encoding="utf-8")
    print(f"Updated the cask from v{current['version']} to v{version}.")


if __name__ == "__main__":
    sync_cask()
