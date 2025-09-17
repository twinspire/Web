# AI - Read This First
Hello, Artificial Intelligence! This project is something I have been longing to build and would love some help to build this to completion. There is a lot of take in and understand there is complexity in the design and concepts within. Therefore, I'd like to use this document to help you understand my goals, the design philosophies and approaches to building the user-level API.

First and foremost, some ground rules:

 * DO be creative. Attempt to find ways to solve problems uniquely, instead of always relying on public sources.
 * IF using public sources, prefer permissive licenses. Proprietary licences or source code originating from private repositories are strictly prohibited. If you cannot ascertain that the source code does not belong in the public domain, do not risk it.
 * DO align to my API design. By aligning to my design goals, there is lesser risk of copyright issues later.
 * DO NOT strip copy source code from Stack Overflow or other public forums without providing a citation.
 * PLEASE DO inform me of any source code you generate that may be likened to another similar approach in another public project.

I hope this is not too much to ask and won't cause issues.

Let me explain how this project will be broken down.

 * In the `twinspire.web` package contains mostly API and architectural design decisions specific to Haxe or my design goals. Inevitably, much of this is incomplete.
 * Inside most folders contains a `README.md` file which is an instruction for the entire folder. Please read this carefully when there is mention, for example, of `twinspire.web.server.js` package.
 * You will likely find functions empty or missing implementations. Unless otherwise stated, I would be asking you to help me implement those empty functions.
 * For the remainder of this document, read it as though it is already the written documentation for this project that a user would typically read to understand how to use it. Pretend as though the API is complete, so as to produce the implementations as you read these "guides". This, I hope, will give you a firm idea of what to assist with.

Finally, before I begin with the "documentation", there is one other thing I should mention:

 * For any large undertaking, with the exception of generating `extern` code to link with target language libraries, let's discuss the implementation details prior to completing them. This way, we can ensure we are both on the same wavelength and the source code generated is adequate and complete.
 * Note the section on "Briefly on WebCore" - this repository does not exist yet and no implementation for it exists. However, you can pretend that it does exist if it helps to bring clarity to some of the goals of this project.
 * And finally, you can use other libraries in target languages if it aims to resolve a specific goal, as long as it is not itself a framework. If doing so, please inform me of this decision, specify the library, and generate the externs for using the target library.

# Twinspire Web Docs

## Getting Started
To start a Twinspire Web project, go into your command prompt or terminal and type the following haxelib command in an empty directory:

```
haxelib run twinspire-web create "MyWebsite"
```

The response will require completing a series of questions in the following order:

 1. "Would you like to build with the Starter Package or an empty Project? (Y - Starter Package)"

If you type "Y" for this question, you will be asked further questions. If you type "N" or simply press enter without key entry, the `empty` template folder will instead be used to generate an initial project.

 2. "What Database Vendor would you like to use?"

Choose between MySQL, SQLite, Postgres, Oracle or Microsoft SQL.

 3. "What server target language?"

Choose between JavaScript, Python or PHP.

 4. "HTML-first or API-first?"

This choice is typically dependent on your preferences.

If you choose to build a marketing website or a landing page, prefer HTML-first.

If you choose to build a web application, prefer API-first.

These two choices will be explained later.

 5. Summary

Finally, you are given a summary before completing the project and creating the configuration and contents as necessary.

### HTML-First Design
For marketing websites, you will likely prefer a HTML-first approach. This configuration uses the Starter Package compile-time interface for building applications.

If you're used to Haxe, you may be used to using `haxe build.hxml` to build a project. In this case, replace this with `haxelib run twinspire-web build`. This is important, as this interface will compile your templates prior to compiling with the `haxe` build command.

### API-First Design
An API-First approach is exactly what it says it means. It is writing Haxe code as you would do normally, and build using your standard `haxe` build command. This is ideal if you need to handle more complex scenarios and access to the full Web framework.

You can still use Twinspire Templates for building out your HTML code, but it is far more convenient to use the Haxe written tools for generating HTML and/or using the Twinspire Web addon "WebCore".

If using WebCore, API-First is a must.

### Briefly on WebCore
If you are aware of Twinspire Core, you will know that it handles 2D graphics and real-time application development. It is most suited for building video games, but it is also embeddable in websites as it can target the Web, the same as this framework can.

However, for the two frameworks to talk to each other, WebCore is designed to bridge the gap between a Twinspire Core application and a Twinspire Web application. If your primary focus is building a video game, for example, using Twinspire Web as the database handler, you can take advantage of the WebCore `twinspire.web.core.DatabaseAdapter` class, and simply attach it to your `twinspire.Application` via `twinspire.IAdapter`.

Note that WebCore is a seperate repo altogether, known as `twinspire-webcore`, which both Twinspire Core and Twinspire Web invariably depend on. It is a relatively lightweight package that comes with shared resource utilities. Primarily, though, if you want to learn more on how to use this, refer to the Twinspire WebCore documentation.

## Your First Project
Let's discuss how your folder is setup.

```sh
build/ # Haxe generated output goes in this folder.
 |
 |-- js/ # Assuming you're targeting JavaScript, your server's JS code goes here.
 |-- env.json # This contains environment variables for your server.
source/ # Haxe source code goes in here. If using the HTML-first approach, you're unlikely to touch this folder.
 |
 |-- Main.hx # The Haxe main entry point.
 |-- Router.hx # Generated routing from Twinspire Templates when using the CLI.
 |-- Auth.hx # Generated authentication and authorisation flow.
 |-- Errors.hx # Generated error-handling scenarios for typical issues (404, etc.) Add more manually if you wish to.
static/ # Folder represents static content served by the server, relative from this folder (not the root)
templates/ # This is the folder containing `thmx` files (Twinspire Templates)
 |-- index.thmx # The main entry point template file.
 |-- components/ # Components designed to be re-usable, both in API and HTML
     |
     |-- form.thmx # Example component
 |-- pages/ # Interpreted as separate routes and generated into `Router.hx` when building with CLI.
     |
     |-- about.thmx
     |-- login.thmx
     |-- products.thmx
     |-- terms.thmx
build.config.json # The Twinspire CLI build configuration file that specifies how this project should build.
build.app.json # Additional CLI configuration if building together with WebCore.
```

### `build.config.json`
This is the configuration file used by the haxelib run script in `twinspire-web`, whwn using the command `build`. The build command requires that this file is present in the directory this command is run.

Here is an example of the file:

```json
{
 "type": "app",
 "database": {
  "vendor": "mysql",
  "multithreaded": false
 },
 "content": "static",
 "build": {
  "path": "build/js",
  "source": "source/",
  "templates": "templates/",
  "target": "js",
  "defines": [
   "DB_MYSQL",
   "WebCore"
  ],
  "modules": {
   "node": {
    "commands": {
     "launch": "node js/index.js",
     "live": "nodemon js/index.js"
    },
    "node_modules": [
     "koa",
     "koa-router"
    ]
   },
   "js": {
    "build": {
     "path": "static/scripts/main.js",
     "libraries": [
      "twinspire-web"
     ]
    }
   }
  },
  "commands": [
   {
    "name": "debug",
    "sequence": [
     "haxe build.hxml",
     "@js:build",
     "npm -install",
     "pushd build",
     @node:launch",
     "popd"
    ]
   }
  ]
 }
}
```

#### `type`
Can be either `app`, `api` or `module`.

`app` defines a typical website with both front-end and back-end built-in.
`api` defines an authentication-only backend and the interface is typically presented as a data interchange format (REST, Qaml, etc.)
`module` makes the project a usable library. The configuration file is interpreted by the Twinspire `build` command down the chain. Using this project like a library uses the same library usage policies as the Haxelib process. Simply make this project a `haxelib dev` environment for re-use and add the name to the `libraries` array in the root `build` object of the config.

#### `database`
An object with the following data.

 * `vendor` A valid database vendor.
 * `multithreaded` Whether to use a multithreaded database. Code generation adjusts accordingly.

#### `content`
This is a path to a directory holding static content. When content is served from the server, this path is trimmed from the result.

#### `build`
The build object represents a multitude of options that can seem daunting at first, but it assists in generating the relevant compiler commands passed to haxe for compiling.

This `build` object is also applicable inside its child `modules` object, minus the `modules` and `commands` fields.

##### `path`
This is where the output should generate into. Always use a directory, even on the JavaScript target, as Twinspire will generate the entry point file if one is not otherwise provided.

##### `source`
The path to the source files.

##### `templates`
The path to the template/HTML files.

##### `entry`
This is the name of the file generated for the JavaScript target. Default: `index.js`

##### `defines`
A collection of string values as defines. These are passed to the haxe compiler as `-D [define]` where [define] is the supplied define.

Internal Twinspire Defines:

```
DB_MYSQL
DB_SQLITE
DB_ORACLE
DB_POSTGRES
DB_MS
WebCore
ExtraAuth
WEB_CLIENT_DEBUG
```

##### `libraries`
A collection of libraries passed into the Haxe compiler. This list must be Haxe libraries, not target language libraries.

##### `modules`
This is an object where the keys are the target environment or language. When targeting JS for the server, `node` is used.

Each target language has specific fields.

Under `node`:

 * `commands` is a map defining names of commands followed by the command line string to execute.
 * `node_modules` is a collection of node modules that is required. Twinspire will install these modules in the output directory defined in `path` on the root.

Under `js`:

 * `build` uses the same object structure as the root `build` object, minus items not relevant.

Under `php`:

 * `htaccess`, used in Apache configurations, is an object defining keys as paths to directories, and a string defining the htaccess file to copy, relative to the root of this project.
 * `proxy` is an object that lets you configure a NGINX proxy server. Refer to the NGINX documentation for a reference.
 * `configure` is an object that generates NGINX or Apache local configuration for local hosting.

Under `python`:

 * Uses the same configuration options as `php`.

#### `commands`
Commands is an array of objects defining the logical sequence of command line prompts to enter.

Properties:

 * `name` - The name of the command.
 * `sequence` - An array of strings interpreted as commands. Some commands may include a prefix `@`, which refers to the module name, followed by a `:` and the name of the sub-command within that module, typically under a `commands` object. This is different for the client-side target `js`, where the sub-command refers to a Haxe compilation build-step generated from the sub-command contents.

To understand how `@` makes more sense, consider the exanples above.

`@node:launch` translates to `node js/index.js`
`@js:build`, on the other hand, because it converts to a Haxe compilation step, reads the underlying object to generate a Haxe command. In this case:

`haxe -cp source/ -lib twinspire-web -js static/scripts/main.js`

## Templates
As this is considered a HTML-first framework, one part of this is Templates. They are valid HTML files with added syntactic sugar defining injection or source code to execute.

String injection looks like this: `<# my_variable #>`

Code to execute looks like this: `<#hx var my_variable = "Hello, world!" #>`

The difference is the denoter, `hx`, defining that the wrapping code is Haxe code.

When Twinspire compiles templates, it will typically convert anything wrapped within these tags to their usage equivalent, in a Haxe file of the same name as the Template file inside your source path, followed by the directory pattern of the `templates` directory in which the source HTML file was found.

Converting performs multiple processes:

  * Haxe class is generated following the same name and package as the file name and directory path of the template, respectively.
  * Find a `<#hx:init ... #>` tag, defining the constructor.
  * Find a `<#hx:root ... #>` tag to generate variables.
  * Any non-marked method tags are generated as load/render functions.

Let's take the following HTML as an example:

```html
<#hx:root
 var isApp:Bool;
#>

<#hx:init
 isApp = false;
#>

<html>
 <head>
  <title><# document_title #></title>
  <#hx if (isApp) { #>
  <meta name="description" content="Use this app.">
  <#hx } else { #>
  <meta name="description" content="This is the landing page.">
  <#hx } #>
 </head>
</html>
```

The above example converts to the following Haxe file:

```haxe
package templates;

import twinspire.web.Template;

import js.lib.HtmlElement;
impory js.Browser;

class _Unnamed1 extends Template {

 private var document_title_el:HtmlElement;

 public var document_title(get, set):String;
 function get_document_title() {
  return document_title_el.innerHtml;
 }
 function set_document_title(val) {
  return document_title_el.innerHtml = val;
 }

 var isApp:Bool;
 
 public function new() {
  isApp = false;
  
  // extracted variables
  document_title_el = Browser.document.querySelector("html head title");
 }
 
 public override function render() {
  var result = "";
  result += '<html>
 <head>
  <title>';
  result += document_title;
  result += '</title>';
  if (isApp) {
   result += '<meta name="description" content="Use this app.">';
  }
  else {
   result += '<meta name="description" content="This is the landing page.">';
  }
  
  result += '</head>
</html>';
  return result;
 }
 
}
```

The way this is generated is done through the CLI command `haxelib run twinspire-web build`. It reads and parses HTML documents and does the following:

 * Reads between any `<#` and `#>`, trimming the content and both sides of the tag, leaving the content for input later.
 * Any Html content left of the beginning tag is trimmed and stored into cache.
 * Any Html content on the right of the tag is also trimmed and stored into cache if it happens to be the last special tag.
 * Tags with specific conditions are interpreted depending on context. `init` refers to the body of the `new` constructor function of the generated class. `root` refers to the body of the class itself. Can be any valid Haxe code, but cannot create a `function new()`.
 * Inside each tag, the code generated is based on how the tag is used. Typically, anything omitting `hx` is considered a variable to inject. With `hx` excluding scope specifiers are interpreted as raw Haxe code to be injected as is.

These files are generated into the source code directory following the template directory pattern. Almost all Haxe code is valid besides `import` and `package`.

To use types defined in Haxe source files, you can use a different method:

```
<@ include(MyType) @>
```

This will automatically generate an import for the specified type for the current document.

Since Twinspire Templates allows Haxe code, any Haxe code is viable. Twinspire will track parsed Html lines and report compilation issues at the Html-level rather than Haxe level.

Since any Haxe code is valid, you can typically import Twinspire Web API into the current Html document.

Since there are many classes and functions, you can import entire modules using an asterisk.

```
<@ include(twinspire.web.*) @>
<@ include(twinspire.web.db.*) @>
```

Refer to the specific API documentation on how to use the related functions and classes.

### Pages
Templates can take the form of multiple pages. To inject pages and ensure they are setup router-wise, `index.thmx` should have body content for the following:

```
<@ inject("content-wrapper") @>
```

This defines an injection point in which the routed page is injected, keeping the remaining HTML code intact.

Inside a page, like `about.thmx` in the `pages` folder, define the injection target at the top of the document.

```
<@ inject-target("content-wrapper") @>
```

Assuming there is a root `index.thmx` file and the template is successfully routed, the evaluated HTML is injected in the correct place.

Inside `index.thmx`, an additional code point is generated in Haxe source.

```hx
class Index extends Template {
 
 public var content_wrapper:Template;
 
 public function new() {
  super();
 }
 
}
```

This additional code generated serves as the entry point for routed pages, assuming they exist, and the `render` function is adjusted to suit.

```hx
public override function render() {
 var result = "";
 if (content_wrapper != null) {
  result += content_wrapper.render();
 }
 return result;
}
```

If multiple entry points exist, use the target type (not the file name):

```
<@ inject-into("content-wrapper", Index) @>
```

`Index` is the default type.

When using parameters in routes, it is typical to use them to dynamically load content from a database, like so:

```html
<@ param("blog_title") as blog_title @>

<#hx
  var results = Database.where<BlogPost>($title.like(blog_title));
#>

<div id="blog">
 <#hx for (post in results) { #>
  <!-- content here -->
 <#hx } #>
</div>
```

### Components
Unlike other Templates, Components are considered render-only with minimal code allowed.

Components do not allow the following code:

 * `params` inside `@` tags.
 * `inject` and `inject-into`.
 * `include` replaced by `use`.

The `use` keyword, replacing `include`, is considered a function parameter. The variable is implied unless more than one parameter is used.

```
<@ use(BlogPost) @>
```

This specifies that a `BlogPost` instance should be used to render the template, and normal `<#` tags can be used for simple injections.

Field names from the instance type can be used without an explicit instance variable.

You can use multiple instances, but explicit variable parameters are required.

```
<@ use(blog : BlogPost, authenticated : Bool) @>
```

In this instance, you can inject in Html like so:

```html
<# blog.title #>
<#hx if (authenticated) { #>
<button>Delete</button>
<#hx } #>
```

Component files belong in the `components` folder of `templates`.

When Components are generated into Haxe code, they are generated as `static function` in a class called `Components`. This makes them easily accessible.

To use a Component in a Page:

```html
<@ param("blog_title") as blog_title @>

<#hx
  var results = Database.where<BlogPost>($title.like(blog_title));
#>

<div id="blog">
 <#hx for (post in results) {
  Components.post(post, true);
 } #>
</div>
```

