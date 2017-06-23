#!/usr/bin/env node

const path = require('path');
const refParser = require('json-schema-ref-parser');

const argPath = process.argv[2];
let source = path.isAbsolute(argPath) ? argPath : path.join(process.cwd(), argPath)

try {
	source = require(source);
} catch(e) {}


refParser.dereference(source)
	.then(schema => console.log(JSON.stringify(schema, null, '  ')))
	.catch(err => console.error(err));


