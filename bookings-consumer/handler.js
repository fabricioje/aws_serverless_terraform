'use strict';

const AWS = require ('aws-sdk')
const converter = AWS.DynamoDB.Converter

module.exports.listen = async event => {
  for(const record of event.Records){
    console.log('JSON parseado', converter.unmarshall(record.dynamodb.NewImage))
  }
  return { message: 'Go Serverless v1.0! Your function executed successfully!', event };
};
