#!/bin/sh -e

RPMBUILD=rpm

if rpmbuild --help >/dev/null
then
    RPMBUILD=rpmbuild
fi

if $RPMBUILD --help >/dev/null
then
    echo RPMBUILD=$RPMBUILD
else
    exit 0
fi

INTDIR=$1
BASEDIR=$2
RPMDIR=$3

test -d "$INTDIR"
test -d "$BASEDIR"
test -d "$RPMDIR"

case "$BASEDIR" in
/* )
	;;
* )
	BASEDIR=`pwd`/"$BASEDIR"
	;;
esac

SPECFILE="$INTDIR/rpm.spec"
TGTPATH="$INTDIR/rpm.dir"

cat >"$SPECFILE"

(
	echo "%files"
	echo "%defattr(-,root,root)"
	cd $BASEDIR

	if test -z "$PKGROOT"
	then
		FIND_ROOT="."
	else
		FIND_ROOT="./$PKGROOT"
	fi

	find "$FIND_ROOT" | while read N
	do
		M=`echo $N | sed s/\.//`
		if test "$M" != ""
		then
			if test -d "$N"
			then
				echo "%dir %attr(555,root,root) $M"
			else
				if test -L "$N"
				then
					echo "$M"
				else
					if test -f "$N"
					then
						if test -x "$N"
						then
							echo "%attr(555,root,root) $M"
						else
							echo "%attr(444,root,root) $M"	
						fi
					fi
				fi
			fi
		fi
	done

	echo
	echo "%clean"
	echo echo clean "$\@"
	echo
) >>$SPECFILE

rm -rf "$TGTPATH"

mkdir "$TGTPATH"

for d in . usr usr/lib
do
	if test -d "$BASEDIR/$d"
	then
		chmod +w "$BASEDIR/$d"
	fi
done

$RPMBUILD --buildroot "$BASEDIR" --define "_build_id_links none" --define "_rpmdir $TGTPATH" -bb "$SPECFILE"

for d in usr/lib usr
do
	if rmdir "$BASEDIR/$d"
	then
		echo removed "$BASEDIR/$d"
	fi
done

find  "$TGTPATH" -type f -name "*.rpm" | while read N
do
	mv "$N" "$RPMDIR"
done

rm -rf "$TGTPATH" "$SPECFILE"
