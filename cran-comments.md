# Test environments
* Local R installation, Windows 10, R 4.0.2
* GitHub Actions
    * R 4.0.2 on Windows Server 2019, Mac OS X 10.15.4 and Ubuntu 16.04
    * R 4.1.0-devel on Mac OS X 10.15.4
    * R R 3.2, 3.4, 3.5, and 3.6 on Ubuntu 16.04
* R 4.1.0-devel on win-builder
* r-hub
    * R 4.1.0-devel on Windows Server 2008 and Fedora Linux
    * R 4.0.0 on Ubuntu 16.04

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
