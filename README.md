Protection Profile for General Purpose Operating System 
===============
![Build](https://github.com/commoncriteria/operatingsystem/workflows/Build/badge.svg)
[![GitHub issues Open](https://img.shields.io/github/issues/commoncriteria/operatingsystem.svg?maxAge=2592000)](https://github.com/commoncriteria/operatingsystem/issues) 
![license](https://img.shields.io/badge/license-Unlicensed-blue.svg)

This repository hosts the draft version of the Protection Profile for a General Purpose Operating System based on the 
[Essential Security Requirements (ESR)](https://commoncriteria.github.io/pp/operatingsystem/operatingsystem-esr.html) for this technology class of 
products. This repository is used to facilitate collaboration and development on the draft document. 
See the [release](#Release-Version) section if you are looking for the officially released version for evaluations. 
A list of products that have passed evaluation against this Protection Profile can be found [here](https://www.niap-ccevs.org/Profile/Info.cfm?id=400).

[cols="1,1,1,1,1,1,1,1"]
|===
8+|operatingsystem 

| https://github.com/commoncriteria/operatingsystem/tree/tdtest[tdtest] 
a| https://commoncriteria.github.io/operatingsystem/tdtest/operatingsystem-release.html[📄]
a|[link=https://github.com/commoncriteria/operatingsystem/blob/gh-pages/tdtest/ValidationReport.txt]
image::https://raw.githubusercontent.com/commoncriteria/operatingsystem/gh-pages/tdtest/validation.svg[Validation]
a|[link=https://github.com/commoncriteria/operatingsystem/blob/gh-pages/tdtest/SanityChecksOutput.md]
image::https://raw.githubusercontent.com/commoncriteria/operatingsystem/gh-pages/tdtest/warnings.svg[SanityChecks]
a|[link=https://github.com/commoncriteria/operatingsystem/blob/gh-pages/tdtest/SpellCheckReport.txt]
image::https://raw.githubusercontent.com/commoncriteria/operatingsystem/gh-pages/tdtest/spell-badge.svg[SpellCheck]
a|[link=https://github.com/commoncriteria/operatingsystem/blob/gh-pages/tdtest/TDValidationReport.txt]
image::https://raw.githubusercontent.com/commoncriteria/operatingsystem/gh-pages/tdtest/tds.svg[TDs]
a|image::https://raw.githubusercontent.com/commoncriteria/operatingsystem/gh-pages/tdtest/transforms.svg[transforms,150]
a| 
https://commoncriteria.github.io/operatingsystem/tdtest/operatingsystem-release-linkable.html[operatingsystem-release-linkable.html] +
https://commoncriteria.github.io/operatingsystem/tdtest/operatingsystem-release.html[operatingsystem-release.html] +
https://commoncriteria.github.io/operatingsystem/tdtest/operatingsystem.html[operatingsystem.html] +
https://commoncriteria.github.io/operatingsystem/tdtest/operatingsystem-paged.pdf[operatingsystem-paged.pdf] +
|===




## Draft Version

* [Protection Profile for General Purpose Operating System](https://commoncriteria.github.io/pp/operatingsystem/operatingsystem-release.html) (html)
* [Protection Profile for General Purpose Operating System](https://commoncriteria.github.io/pp/operatingsystem/operatingsystem-release.pdf) (pdf)
* [Configuration Annex to the General Purpose Operating System](https://commoncriteria.github.io/pp/operatingsystem/configannex.html) (html)

## Release Version

* [Protection Profile for General Purpose Operating System v4.1](https://www.niap-ccevs.org/Profile/Info.cfm?id=400)

## Contributing

If you are interested in contributing directly to future versions the this Protection Profile, please consider joining the NIAP technical community.
* [How to join the NIAP Technical Community (Mailing list and updates)](https://www.niap-ccevs.org/NIAP_Evolution/tech_communities.cfm)

## Feedback

Questions, comments, and fixes can be submitted to the [repository issue tracker](https://github.com/commoncriteria/operatingsystem/issues)

## Quickstart
To clone this project along with its _transforms_ submodule run:

````
  git clone --recursive git@github.com:commoncriteria/operatingsystem.git
````
To pull updates from the upstream _transforms_ submodule and commit them run:
````
 git submodule update --remote transforms
 git add transforms
 git commit
````


### Development Info
* [Help working with Transforms Submodule](https://github.com/commoncriteria/transforms/wiki/Working-with-Transforms-as-a-Submodule)
* [Protection Profile Development Getting Started Guide](https://github.com/commoncriteria/pp-template/wiki)


## Repository Content
* input - Contains the 'meat' of the project. It's the input content (in XML form) that gets transformed to readable html.
* output - The output directory where the html is placed after transformation.
* output/images - The directory where images are stored
* transforms - Points to the transform subproject which is really a repository for resources shared amongst many Common Criteria projects.


## Links 
* [National Information Assurance Partnership (NIAP)](https://www.niap-ccevs.org/)
* [Common Criteria Portal](https://www.commoncriteriaportal.org/)


## License

See [License](./LICENSE)
