# selinux

[![PRs Welcome](https://img.shields.io/badge/prs-welcome-brightgreen.svg)](http://makeapullrequest.com)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What selinux affects](#what-selinux-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with selinux](#beginning-with-selinux)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)
    * [Contributing](#contributing)

## Overview

Disables SELinux, what else anyone would like to do anyway?

## Module Description

This module is meant to disables SELinux. What else anyone would like to do anyway?

## Setup

### What selinux affects

Manages **/etc/selinux/config**

### Setup Requirements

This module requires pluginsync enabled

### Beginning with selinux

Disable SELinux
```
class { 'selinux':
  mode => 'disabled',
}
```

## Usage

There are three SELinux modes available:
* disabled
* permissive
* enforcing


## Reference

### selinux

* mode: (default: disabled)
  * disabled
  * permissive
  * enforcing

## Limitations

Tested on:
* CentOS 6

## Development

We are pushing to have acceptance testing in place, so any new feature should
have some tests to check both presence and absence of any feature

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
