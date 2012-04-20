---
source:
- meta
- meta/
authors:
- name: trans
  email: transfire@gmail.com
copyrights: []
requirements:
- name: rdoc
  version: 3+
- name: shomen-model
- name: detroit
  groups:
  - build
  development: true
dependencies: []
alternatives: []
conflicts: []
repositories:
- uri: git://github.com/rubyworks/shomen-rdoc.git
  scm: git
  name: upstream
resources:
- uri: http://rubyworks.github.com/shomen-rdoc
  name: home
  type: home
- uri: http://github.com/rubyworks/shomen-rdoc/wiki
  name: docs
  type: doc
- uri: http://github.com/rubyworks/shomen-rdoc
  name: code
  type: code
- uri: http://github.com/rubyworks/shomen-rdoc/issues
  name: bugs
  type: bugs
- uri: http://groups.google.com/groups/rubyworks-mailinglist
  name: mail
  type: mail
- uri: http://chat.us.freenode.net/rubyworks
  name: chat
  type: chat
extra: {}
load_path:
- lib
revision: 0
created: '2010-07-01'
summary: Shomen Documentation via RDoc
title: Shomen RDoc
version: 0.1.0
name: shomen-rdoc
description: ! 'Shomen RDoc provides a command line utility for generating Shomen
  standard

  documentation via the RDoc''s `.rdoc` cache. It is an alternative to the

  `rdoc-shomen` format plugin.'
organization: rubyworks
date: '2012-04-19'
