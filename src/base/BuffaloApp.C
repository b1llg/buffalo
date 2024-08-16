#include "BuffaloApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"

InputParameters
BuffaloApp::validParams()
{
  InputParameters params = MooseApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  params.set<bool>("use_legacy_initial_residual_evaluation_behavior") = false;
  return params;
}

BuffaloApp::BuffaloApp(InputParameters parameters) : MooseApp(parameters)
{
  BuffaloApp::registerAll(_factory, _action_factory, _syntax);
}

BuffaloApp::~BuffaloApp() {}

void
BuffaloApp::registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  ModulesApp::registerAllObjects<BuffaloApp>(f, af, s);
  Registry::registerObjectsTo(f, {"BuffaloApp"});
  Registry::registerActionsTo(af, {"BuffaloApp"});

  /* register custom execute flags, action syntax, etc. here */
}

void
BuffaloApp::registerApps()
{
  registerApp(BuffaloApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
extern "C" void
BuffaloApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  BuffaloApp::registerAll(f, af, s);
}
extern "C" void
BuffaloApp__registerApps()
{
  BuffaloApp::registerApps();
}
