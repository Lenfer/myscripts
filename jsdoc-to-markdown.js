#!/usr/bin/env node

const path = require('path');
const fs = require('fs');
const jsdoc2md = require('jsdoc-to-markdown');

const argPath = process.argv[2];
let source = path.isAbsolute(argPath) ? argPath : path.join(process.cwd(), argPath)

try {
	source = fs.readFileSync(source, 'utf8');
} catch(e) {
	return console.log(e.message);
}


jsdoc2md
	.render({
	    'no-cache': true,
	    source
	})
	.then(console.log);

