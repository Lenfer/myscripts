#!/usr/bin/env node

const path = require('path');
const refParser = require('json-schema-ref-parser');

let source = path.join(process.cwd(), process.argv[2])

try {
	source = require(source);
} catch(e) {}


refParser.dereference(source)
	.then(schema => console.log(JSON.stringify(schema, null, '  ')))
	.catch(err => console.error(err));


