#!/bin/sh

if setxkbmap -query| grep "us" ; then
	setxkbmap no ;
else 
	setxkbmap us ;
fi
