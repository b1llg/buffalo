//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html
#include "BuffaloTestApp.h"
#include "BuffaloApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "MooseSyntax.h"

InputParameters
BuffaloTestApp::validParams()
{
  InputParameters params = BuffaloApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  params.set<bool>("use_legacy_initial_residual_evaluation_behavior") = false;
  return params;
}

BuffaloTestApp::BuffaloTestApp(InputParameters parameters) : MooseApp(parameters)
{
  BuffaloTestApp::registerAll(
      _factory, _action_factory, _syntax, getParam<bool>("allow_test_objects"));
}

BuffaloTestApp::~BuffaloTestApp() {}

void
BuffaloTestApp::registerAll(Factory & f, ActionFactory & af, Syntax & s, bool use_test_objs)
{
  BuffaloApp::registerAll(f, af, s);
  if (use_test_objs)
  {
    Registry::registerObjectsTo(f, {"BuffaloTestApp"});
    Registry::registerActionsTo(af, {"BuffaloTestApp"});
  }
}

void
BuffaloTestApp::registerApps()
{
  registerApp(BuffaloApp);
  registerApp(BuffaloTestApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
// External entry point for dynamic application loading
extern "C" void
BuffaloTestApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  BuffaloTestApp::registerAll(f, af, s);
}
extern "C" void
BuffaloTestApp__registerApps()
{
  BuffaloTestApp::registerApps();
}
