#!node_modules/bats/libexec/bats

# check the loading of all webpages of Autolab

@test "load index.html page from main_server" {
	mkdir -p "$BATS_TMPDIR/index-page"
	curl -s --ipv4 -k https://127.0.0.1:9000 -o "$BATS_TMPDIR/index-page/index.html"
	cmp data/autolab-start/index.html "$BATS_TMPDIR/index-page/index.html"
	result=$?
	rm -rf "$BATS_TMPDIR/index-page"
	[ "$result" -eq 0 ]
}

@test "load Autolab status page" {
	mkdir "$BATS_TMPDIR/status"
	curl -s --ipv4 -k https://127.0.0.1:9000/status -o "$BATS_TMPDIR/status/status.txt"
	cmp "$BATS_TMPDIR/status/status.txt" data/autolab-start/status.txt
	result=$?
	rm -rf "$BATS_TMPDIR/status"
	[ "$result" -eq 0 ]
}

# for the following tests, you need to extract the links from index.html
# see http://stackoverflow.com/questions/9561020/how-do-i-use-the-python-scrapy-module-to-list-all-the-urls-from-my-website

@test "load Autolab-specific client-side js files" {
	mkdir "$BATS_TMPDIR/js"
	curl -s --ipv4 -k https://127.0.0.1:9000/js/userlogic.js -o "$BATS_TMPDIR/js/userlogic.js"
	cmp "$BATS_TMPDIR/js/userlogic.js" data/autolab-start/js/userlogic.js
	result=$?
	rm -rf "$BATS_TMPDIR/js"
	[ "$result" -eq 0 ]
}

@test "load third-party js libraries" {
	# check for jquery.min.js, socket.io.js, materialize.min.js, Filesaver.js
	mkdir "$BATS_TMPDIR/js"
	curl -s --ipv4 -k https://127.0.0.1:9000/js/jquery.min.js -o "$BATS_TMPDIR/js/jquery.min.js"
	cmp "$BATS_TMPDIR/js/jquery.min.js" data/autolab-start/js/jquery.min.js
	result=$?
	rm -rf "$BATS_TMPDIR/js"
	[ "$result" -eq 0 ]

	mkdir "$BATS_TMPDIR/js"
	curl -s --ipv4 -k https://127.0.0.1:9000/socket.io/socket.io.js -o "$BATS_TMPDIR/js/socket.io.js"
	cmp "$BATS_TMPDIR/js/socket.io.js" data/autolab-start/js/socket.io.js
	result=$?
	rm -rf "$BATS_TMPDIR/js"
	[ "$result" -eq 0 ]

	mkdir "$BATS_TMPDIR/js"
	curl -s --ipv4 -k https://127.0.0.1:9000/js/materialize.min.js -o "$BATS_TMPDIR/js/materialize.min.js"
	cmp "$BATS_TMPDIR/js/materialize.min.js" data/autolab-start/js/materialize.min.js
	result=$?
	rm -rf "$BATS_TMPDIR/js"
	[ "$result" -eq 0 ]

	mkdir "$BATS_TMPDIR/js"
	curl -s --ipv4 -k https://127.0.0.1:9000/js/Filesaver.js -o "$BATS_TMPDIR/js/Filesaver.js"
	cmp "$BATS_TMPDIR/js/Filesaver.js" data/autolab-start/js/Filesaver.js
	result=$?
	rm -rf "$BATS_TMPDIR/js"
	[ "$result" -eq 0 ]
}

@test "load third-party css files" {
	# check for css/*.css files
	skip "TODO"
}

@test "check all hyperlinks" {
	# check for live status of all http(s) href URLs on the page.
	skip "TODO"
}
