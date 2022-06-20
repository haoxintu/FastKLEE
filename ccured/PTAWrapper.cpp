#include "PTAWrapper.hh"

using namespace llvm;
using namespace SVF;

void alias::PTAWrapper::setupPTA(Module &M)
{
  SVFModule *module = LLVMModuleSet::getLLVMModuleSet()->buildSVFModule(M);
  PAGBuilder builder;
  PAG *pag = builder.build(module);
  _ander_pta = AndersenWaveDiff::createAndersenWaveDiff(pag);
}

AliasResult alias::PTAWrapper::queryAlias(Value &v1, Value &v2)
{
  assert(_ander_pta != nullptr && "cannot obtain ander pointer analysis!\n");
  return _ander_pta->alias(&v1, &v2);
}
  //PAG* alias::PTAWrapper::getPAG() override
	//{
	//	return pag;
	//}
