const authorsResponseMap = {
  'uid': '5dffe3b1-61bf-4d74-90d5-44820e57e21a',
  'timeMs': 884,
  'code': 200,
  'headers': {
    'alt-svc': 'h3=":443"; ma=2592000,h3-29=":443"; ma=2592000',
    'cache-control': 'private',
    'content-encoding': 'gzip',
    'content-type': 'application/json; charset=UTF-8',
    'date': 'Mon, 30 Oct 2023 15:29:11 GMT',
    'server': 'ESF',
    'transfer-encoding': 'chunked',
    'vary': 'Origin',
    'x-content-type-options': 'nosniff',
    'x-frame-options': 'SAMEORIGIN',
    'x-xss-protection': '0',
  },
  'body': [
    {
      "author": {
        "name": "Dane Mackier",
        "email": "dane@filledstacks.com",
        "avatar": "https://avatar.filledstacks.com/user/dane.mackier"
      }
    },
    {
      "author": {
        "name": "Fernando Ferrara",
        "email": "fernando@filledstacks.com",
        "avatar": "https://avatar.filledstacks.com/user/fernando.ferrara"
      }
    }
  ],
  'view': '/books-list-view',
  'order': 1698679750044,
  'startedAt': 1698679750044,
};

const authorsExpectedResponseMap = {
  'uid': '5dffe3b1-61bf-4d74-90d5-44820e57e21a',
  'timeMs': 999,
  'code': 200,
  'headers': {
    'alt-svc': 'x9xx:999x; xxx9999999,x9-99xx:999x; xxx9999999',
    'cache-control': 'xxxxxxx',
    'content-encoding': 'gzip',
    'content-type': 'application/json; charset=UTF-8',
    'date': 'xxx, 99 xxx 9999 99:99:99 xxx',
    'server': 'xxx',
    'transfer-encoding': 'chunked',
    'vary': 'xxxxxx',
    'x-content-type-options': 'xxxxxxx',
    'x-frame-options': 'xxxxxxxxxx',
    'x-xss-protection': '9',
  },
  'error': null,
  'body': [
    {
      'author': {
        'name': 'xxxx xxxxxxx',
        'email': 'xxxx@xxxxxxxxxxxx.xxx',
        'avatar': 'xxxxx:xxxxxxxx.xxxxxxxxxxxx.xxxxxxxxxxxxx.xxxxxxx'
      }
    },
    {
      'author': {
        'name': 'xxxxxxxx xxxxxxx',
        'email': 'xxxxxxxx@xxxxxxxxxxxx.xxx',
        'avatar': 'xxxxx:xxxxxxxx.xxxxxxxxxxxx.xxxxxxxxxxxxxxxxx.xxxxxxx'
      }
    }
  ],
  'view': '/books-list-view',
  'order': 1698679750044,
  'startedAt': 1698679750044,
};
