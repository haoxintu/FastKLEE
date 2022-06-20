#ifndef GRAPHTRAITS_H_
#define GRAPHTRAITS_H_
#include "ProgramDependencyGraph.hh"

namespace llvm
{
  template <>
  struct GraphTraits<pdg::Node *> 
  {
    using NodeType = pdg::Node;
    using NodeRef = pdg::Node *;
    using ChildIteratorType = pdg::Node::iterator;

    static NodeType *getEntryNode(pdg::Node *N) { return N; }
    static ChildIteratorType child_begin(NodeRef N) { return ChildIteratorType(N); }
    static ChildIteratorType child_end(NodeRef N) { return ChildIteratorType(N, true); }
  };

  template<>
  struct GraphTraits<pdg::ProgramDependencyGraph *> 
  {
    using NodeType = pdg::Node;
    using NodeRef = pdg::Node *;
    using ChildIteratorType = pdg::Node::iterator;
    using nodes_iterator = pdg::ProgramGraph::NodeSet::iterator;

    static NodeRef getEntryNode(pdg::ProgramDependencyGraph *G) { return *G->getPDG()->begin(); }
    static nodes_iterator nodes_begin(pdg::ProgramDependencyGraph *G) { return G->getPDG()->begin(); }
    static nodes_iterator nodes_end(pdg::ProgramDependencyGraph *G) { return G->getPDG()->end(); }
    static ChildIteratorType child_begin(NodeRef N) { return ChildIteratorType(N); }
    static ChildIteratorType child_end(NodeRef N) { return ChildIteratorType(N, true); }
  };

  // template <>
  // struct GraphTraits<const pdg::ProgramGraph *>
  // {
  //   using NodeType = const pdg::Node;
  //   using NodeRef = const pdg::Node *;
  //   using ChildIteratorType = pdg::Node::const_iterator;
  //   using nodes_iterator = pdg::ProgramGraph::NodeSet::const_iterator;

  //   static nodes_iterator nodes_begin(const pdg::ProgramGraph *G) { return G->begin(); }
  //   static nodes_iterator nodes_end(const pdg::ProgramGraph *G) { return G->end(); }
  //   static ChildIteratorType child_begin(NodeRef N) { return ChildIteratorType(N); }
  //   static ChildIteratorType child_end(NodeRef N) { return ChildIteratorType(N, true); }
  // };
}

#endif