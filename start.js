#!/usr/bin/env node

// Force IPv4 DNS resolution before anything else loads
const dns = require('dns');
dns.setDefaultResultOrder('ipv4first');

// Now start Strapi
const strapi = require('@strapi/strapi');
strapi.createStrapi().start();
