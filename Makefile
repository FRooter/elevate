.PHONY: test cover tags clean

test:
	perl -cw elevate-cpanel
	/usr/local/cpanel/3rdparty/bin/prove t/00_load.t
	/usr/local/cpanel/3rdparty/bin/yath test -j8 t/*.t

cover:
	/usr/bin/rm -rf cover_db
	HARNESS_PERL_SWITCHES="-MDevel::Cover=-loose_perms,on,-coverage,statement,branch,condition,subroutine,-ignore,.,-select,elevate-cpanel" prove -j8 t/*.t ||:
	cover -silent
	find cover_db -type f -exec chmod 644 {} \;
	find cover_db -type d -exec chmod 755 {} \;

tags:
	/usr/bin/ctags -R --languages=perl elevate-cpanel t

clean:
	rm -f tags
