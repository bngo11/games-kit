#!/usr/bin/env python3

import json

async def generate(hub, **pkginfo):
	github_user = github_repo = pkginfo.get("name")
	json_data = await hub.pkgtools.fetch.get_page(f"https://api.github.com/repos/{github_user}/{github_repo}/releases", is_json=True)
	version = None
	url = None

	for item in json_data:
		try:
			if item["prerelease"] or item["draft"]:
				continue

			version = item["tag_name"].lstrip("v")
			list(map(int, version.split(".")))

			for asset in item['assets']:
				asset_name = asset["name"]

				if asset_name.endswith(".jar"):
					url = asset["browser_download_url"]
					break

			if url:
				break

		except (KeyError, IndexError, ValueError):
			continue

	if version and url:
		icon_url = "https://raw.githubusercontent.com/ATLauncher/ATLauncher/master/src/main/resources/assets/image/icon.ico"
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=asset_name),
						hub.pkgtools.ebuild.Artifact(url=icon_url, final_name=f"{github_repo}.ico")]
		)
		ebuild.push()

# vim: ts=4 sw=4 noet
