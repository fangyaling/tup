#! /bin/sh -e
# tup - A file-based build system
#
# Copyright (C) 2009-2021  Mike Shal <marfey@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

# If a generated file hasn't been created yet, doing a scan shouldn't cause the
# directory to get put into the create list.
. ./tup.sh

check_empty_create()
{
	if tup create_flags_exists; then
		:
	else
		echo "*** Nodes shouldn't have create flags set" 1>&2
		exit 1
	fi
}

cat > Tupfile << HERE
: foreach *.c |> gcc -c %f -o %o |> %B.o
HERE
touch foo.c
parse
check_empty_create

tup scan
check_empty_create

eotup
