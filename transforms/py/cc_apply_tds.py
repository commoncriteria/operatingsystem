#!/usr/bin/env python3
import sys
import pathlib
#import xml.etree.ElementTree as ET
import lxml.etree as ET

default_ns = {'cc': "https://niap-ccevs.org/cc/v1",
      'sec': "https://niap-ccevs.org/cc/v1/section",
      'htm': "http://www.w3.org/1999/xhtml"}

def get_num(fullpath):
    path = pathlib.Path(fullpath)
    try:
        return int( path.stem )
    except ValueError:
        return sys.maxsize
#        return 99999

def log(msg):
    sys.stderr.write(msg)
    sys.stderr.write("\n")


def apply_tds(main_path, tds):
    doc = ET.parse(main_path)
    root = doc.getroot()
    parent_map = {c: p for p in root.iter() for c in p}
    ET.register_namespace('cc',"https://niap-ccevs.org/cc/v1")
    ET.register_namespace('sec',"https://niap-ccevs.org/cc/v1/section")
    ET.register_namespace('h', "http://www.w3.org/1999/xhtml")
    # Need to sort
    tds.sort(key=get_num)
    for td_path in tds:
        log("Parsing: "+td_path)
        td = ET.parse(td_path).getroot()
        ns_el = td.find(".//cc:xpath_namespaces",default_ns)
        if ns_el is None:
            ns = default_ns
        else:
            ns =ns_el.attrib 
        replaces = td.findall(".//cc:replace", ns)
        for replace in replaces:
            for xpath_spec in replace.findall(".//cc:xpath-specified", ns):
                xpath = "."+ xpath_spec.attrib["xpath"]
                matches = root.xpath(xpath, namespaces=ns)
                #                replaced = root.find(xpath, ns)
                if not len(matches)==1:
                    log("Found "+ str(len(replaced))+ " nodes using:::"  + xpath + "::: Expected 1")
                    continue
                replaced = matches[0]
                parent = parent_map[replaced]
                if parent is None:
                    log("Cannot find parent")
                    continue
                kid_cache = []
                for kid in list(parent):
                    if kid == replaced:
                        log("Adding: " )
                        for newkids in list(xpath_spec):
                            kid_cache.append(newkids)
                    else:
                        kid_cache.append(kid)
                    parent.remove(kid)
                for kid in kid_cache:
                    parent.append(kid)
    print(ET.tostring(root, encoding='unicode', method='xml'))

    
if __name__ == "__main__":
    if len(sys.argv)==1:
        print("Usage: <input-file> [<td1> [<td2> ...]]")
        sys.exit(0)

    apply_tds(sys.argv[1], sys.argv[2:])
