# Transitive Dependencies Kata
A concise Swift 2.2 implementation of Dave Thomas's [Transitive Dependencies](http://codekata.com/kata/kata18-transitive-dependencies/) programming exercise, also known as a _kata_.

My approach to solving this problem involves visiting nodes in a dependency graph by iterating through a node's direct dependencies, recursing into indirect dependencies if possible. A `Set` collection is used to accumulate dependencies when applying `reduce` to a node's direct dependencies. That `Set` is also used to check if a node has already been visited, to avoid navigating cyclical dependencies.

Check out the details in [main.swift](/TransitiveDepsKata/main.swift).
