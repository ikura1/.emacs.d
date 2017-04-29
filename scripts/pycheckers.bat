@echo off
pyflakes  %1 & pep8 --ignore=E221,E701,E202 --repeat %1 & pylint --output-format=parseable --reports=no --disable=C0103,W0108,C0111,W0142,C0202,C0301,C0322,C0323,E1002,W0141,W0232,W0621,W0702,R0904,R0902,R0903,R0201,R0913,R0921,E1101,E1102,E1103,E0611 %1
