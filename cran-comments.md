# Test environments
* Local R installation, Windows 10, R 4.0.2
* GitHub Actions
    * R devel on Ubuntu 18.04
    * R 4.1.1 on Windows Server 2019, Mac OS X 10.15.7 and Ubuntu 18.04
    * R 3.6.3 on Windows Server 2019 and Ubuntu 18.04
    * R 3.4.4, 3.5.3, and 4.0.5 on Ubuntu 18.04
* R devel on win-builder
* r-hub
    * R devel on Windows Server 2008 and Fedora Linux
    * R 4.1.1 on Ubuntu 20.04

# R CMD check results

0 errors | 0 warnings | 1 note

* Found the following (possibly) invalid URLs:
  URL: https://codecov.io/gh/rossellhayes/nombre
    From: README.md
    Status: Error
    Message: libcurl error code 35:
      	schannel: next InitializeSecurityContext failed: SEC_E_ILLEGAL_MESSAGE (0x80090326) - This error usually occurs when a fatal SSL/TLS alert is received 

* I believe this NOTE is a false positive
    - The NOTE appears on win-builder, but not my local install or GitHub actions
    - Opening the link in a browser does not result in any SSL/TLS errors
    
# Reverse dependencies

* I am the maintainer of the only reverse dependency, plu
  - This update introduces no imcompatibilities
