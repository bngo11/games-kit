#!/usr/bin/env python3

from bs4 import BeautifulSoup
import re

VERSION = re.compile(r"./Xonotic-(\d+)\.zip")

async def generate(hub, **pkginfo):
	html_data = await hub.pkgtools.fetch.get_page("https://beta.xonotic.org/autobuild")
	soup = BeautifulSoup(html_data, "html.parser")
	links = soup.find_all("a")
	version = None

	for link in links:
		href = link.get("href")
		if href and "Xonotic" in href:
			found = VERSION.search(href)
			if found:
				version = int(found.groups()[0])
				break

	if version:
		final_name = f"Xonotic-{version}.zip"
		url = f"https://beta.xonotic.org/autobuild/{final_name}"
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)],
		)

		ebuild.push()


# vim: ts=4 sw=4 noet
