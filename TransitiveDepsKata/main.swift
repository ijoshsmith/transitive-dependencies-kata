//
//  main.swift
//  TransitiveDepsKata
//
//  Created by Joshua Smith on 6/5/16.
//  Copyright © 2016 iJoshSmith. All rights reserved.
//
// Solution to the programming exercise at http://codekata.com/kata/kata18-transitive-dependencies/

struct DependencyResolver {
    typealias Node = String
    typealias NodeSet = Set<Node>
    
    let directDependencies: [Node: [Node]]
    
    func dependenciesOf(node: Node) -> [Node] {
        let initialNode = NodeSet([node])
        let dependencies = dependenciesOf(node, visitedNodes: initialNode)
        return dependencies.subtract(initialNode).sort()
    }
    
    private func dependenciesOf(node: Node, visitedNodes: NodeSet) -> NodeSet {
        guard let nodes = directDependencies[node] else { return visitedNodes }
        let unvisitedNodes = nodes.filter { visitedNodes.contains($0) == false }
        return unvisitedNodes.reduce(visitedNodes, combine: visitNode)
    }
    
    private func visitNode(visitedNodes: NodeSet, node: Node) -> NodeSet {
        let dependencies = dependenciesOf(node, visitedNodes: visitedNodes.union([node]))
        return visitedNodes.union(dependencies)
    }
}



// Dependency Tree

let treeResolver = DependencyResolver(directDependencies: [
    "A": ["B", "C"],
    "B": ["C", "E"],
    "C": ["G"],
    "D": ["A", "F"],
    "E": ["F"],
    "F": ["H"],
    ])

assert(treeResolver.dependenciesOf("A") == ["B", "C", "E", "F", "G", "H"])
assert(treeResolver.dependenciesOf("B") == ["C", "E", "F", "G", "H"])
assert(treeResolver.dependenciesOf("C") == ["G"])
assert(treeResolver.dependenciesOf("D") == ["A", "B", "C", "E", "F", "G", "H"])
assert(treeResolver.dependenciesOf("E") == ["F", "H"])
assert(treeResolver.dependenciesOf("F") == ["H"])



// Dependency Graph

let graphResolver = DependencyResolver(directDependencies: [
    "A": ["B"],
    "B": ["C"],
    "C": ["A"]
    ])

assert(graphResolver.dependenciesOf("A") == ["B", "C"])
assert(graphResolver.dependenciesOf("B") == ["A", "C"])
assert(graphResolver.dependenciesOf("C") == ["A", "B"])

print("Success!")
