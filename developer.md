This is to assist developers who are working on Diametric.

== Structure

As you know, this project has two ways of connecting to a Datomic server,
REST and Peer. The REST interface is handled within the lib/persistence
directory. Part of the Peer interface is handled within the lib/persistence
directory, but the bulk of it is done with a set of Java classes in
the ext/diametric directory.

== Working on Peer connection code

The code in ext/diametric needs to be compiled before it can be tested
or used in a project that depends on it (locally). When the code is
compiled, it ends up in lib/diametric.jar. To compile it run the
following:

```
rake compile:diametric_service
```

You can debug the code by inserting System.out.println() at various
points in the java code.

== Upgrading the datomic jar file used

I am not sure if all these steps are required, but I got it to upgrade
by:

# modifying datomic\_version.yml to insert the version that you want to use
# bundle install
# rake compile
