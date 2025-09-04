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

 * In the `twinspire.web` package contains mostly API and architectural design decisions specific to Haxe or my design goals. Invariably, much of this is incomplete.
 * Inside most folders contains a `README.md` file which is an instruction for the entire folder. Please read this carefully when there is mention, for example, of `twinspire.web.server.js` package, or an abbreviation of sorts.
 * You will likely find functions empty or missing implementations. Unless otherwise stated, I would be asking you to help me implement those empty functions.
 * For the remainder of this document, read it as though it is already the written documentation for this project that a user would typically read to understand how to use it. Pretend as though the API is complete, so as to produce the implementations as you read these "guides". This, I hope, will give you a firm idea of what to assist with.

Finally, before I begin with the "documentation", there is one other thing I should mention:

 * For any large undertaking, with the exception of generating `extern` code to link with target language libraries, let's discuss the implementation details prior to completing them. This way, we can ensure we are both on the same wavelength and the source code generated is adequate and complete.
 * Note the section on "Briefly on WebCore" - this repository does not exist yet and no implementation for it exists. However, you can pretend that it does exist if it helps to bring clarity to some of the goals of this project.

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

