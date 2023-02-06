#!/usr/bin/env python3
import os
import xml.etree.ElementTree as ET
import sys
from urllib.request import urlopen
from pathlib import Path

def get_data_at_url(url):
    try:
        return urlopen(url).read()
    except (urllib.error.URLError, IOError) as e:
        if url[:5] == 'https':
            url = url.replace('https:', 'http:')
            print('Failed download. Trying https -> http instead.')

            return urlopen(url).read()




if __name__ == "__main__":
    if len(sys.argv) == 1:
        print("Usage: resolve_names_and_versions.py <path-to-document>")
        sys.exit(0)

    ns = {'cc': "https://niap-ccevs.org/cc/v1",
          'sec': "https://niap-ccevs.org/cc/v1/section",
          'htm': "http://www.w3.org/1999/xhtml"}

    if sys.argv[1].startswith("https:"):
        root = ET.fromstring(get_data_at_url(sys.argv[1]))
        name = sys.argv[1].split('/')[4]
        
    else:
        name = Path(os.path.abspath(sys.argv[1])).parent.parent.name

        root = ET.parse(sys.argv[1]).getroot()
        
    print("<versions>")
    print("  <self version='"+ root.find(".//cc:PPVersion",ns).text+ "' ")
    print("        name='"+name+"'/>'")
    for pkg in root.findall(".//cc:include-pkg", ns)+\
          root.findall(".//cc:base-pp", ns)+\
          root.findall(".//cc:module", ns):
        print("<"+pkg.tag.split("}")[1]+" rel-id='"+pkg.attrib["id"]+"'")
        url=pkg.find(".//cc:raw-url", ns)
        if url==None:
            print(" version='"+pkg.attrib["version"]+"'")
            print(" name='"+pkg.attrib["name"]+"'/>")
        else:
            url_vector=url.text.split("/")
            print(" version='"+url_vector[5].strip()+"'")
            print(" name='"+url_vector[4].strip()+"'/>")
# https://raw.githubusercontent.com/commoncriteria/tls/v1.1/input/tls.xml
# https://raw.githubusercontent.com/commoncriteria/tls/ed2d9042c27f7793d1f96e08e47bd12b04970977/input/tls.xml
    print("</versions>")


        
