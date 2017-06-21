#!/usr/bin/env node

const _ = require('lodash');
const jsonPath = require('JSONPath');

const jsf = require('json-schema-faker');

jsf.extend('faker', function() {
	const faker = require('faker');
	faker.locale = "ru";
	return faker;
});



const HELPERS = {
	jsonPathTraverser(data, path, handler) {
		const objectProps = jsonPath({
			json: data,
			path
		});
		_.each(objectProps, handler);
		return data;
	}
}


const DECLARATIONS = {

	// Выставляем всем рутовым полям обязательность
	rootRequired(data) {
		return _.set(data, 'required', _.keys(data.properties));
	},

	// Выставляем рекурсивно для всех полей обязательность
	recursiveRequired: data => HELPERS.jsonPathTraverser(
		data
		, "$..[?(@.type=='object')]"
		, prop => prop.required = _.keys(prop.properties)
	),

	// Выставляем всем полям которые относятся к гуидам правила для генерации
	guid: data => HELPERS.jsonPathTraverser(
		data
		, "$..[?(@.pattern=='^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$')]"
		, prop => prop.faker = 'random.uuid'
	),


	// доопределим примечание
	note: data => HELPERS.jsonPathTraverser(
		data
		, '$..note'
		, prop => prop.faker = 'lorem.paragraph'
	),

	// Подхачим номера
	number: data => HELPERS.jsonPathTraverser(
		data
		, '$..number'
		, prop => prop.pattern = '^[0-9]{2}-[0-9]{2}-[0-9]{6}(-[0-9]{2})?(-[0-9]{2})?$'
	),

	// Подхачим все заголовки
	title: data => HELPERS.jsonPathTraverser(
		data
		, '$.properties.title'
		, prop => prop.faker = 'commerce.productName'
	),

	// Подхачим все заголовки/имена
	name: data => HELPERS.jsonPathTraverser(
		data
		, '$..name'
		, prop => prop.faker = 'commerce.productName'
	),

	// ИНН
	inn: data => HELPERS.jsonPathTraverser(
		data
		, '$..inn'
		, prop => prop.pattern = '^[0-9]{22}$'
	),

	// Поное имя
	fullName: data => HELPERS.jsonPathTraverser(
		data
		, '$..full_name'
		, prop => prop.faker = 'name.findName'
	),

	// Должность
	post: data => HELPERS.jsonPathTraverser(
		data
		, '$..post'
		, prop => prop.faker = 'name.jobTitle'
	),


	// date_create_original
	dateCreateOriginal: data => HELPERS.jsonPathTraverser(
		data
		, '$.properties.date_create_original'
		, prop => prop.format = 'date-time'
	),




};




/**
 * Запускаем процесс подготовки схемы
 */
function fakerProcess(schenaObject) {
	const data = _.reduce(DECLARATIONS, (res, func) => func(res), schenaObject);

	// const tst = JSON.stringify(data, null, '  ');
	// console.log(tst);

	jsf
		.resolve(data)
		.then(fake => {
			const output = JSON.stringify(fake, null, '  ');
			console.log(output);
		})
		.catch(console.error);
}




/*
 * ===============================================
 */
let stdinData = '';
const stdin = process.openStdin();
stdin.on('data', chunk => stdinData += chunk);
stdin.on('end', () => {
	const data = JSON.parse(stdinData);
	fakerProcess(data);
});
