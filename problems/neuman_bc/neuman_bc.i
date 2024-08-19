[GlobalParams]
    displacements = 'disp_x disp_y disp_z'
[]

[Mesh]
    [generated]
        type = GeneratedMeshGenerator
        dim = 3
        nx = 20
        ny = 3
        nz = 3
        xmax = 5
        ymax = 1
        zmax = 1
        elem_type = HEX27
    []
[]

[Physics]

    [SolidMechanics]

        [QuasiStatic]

            [all]

                add_variables = true
                generate_output = 'vonmises_stress'
            []
        []
    []
[]

[BCs]
    [traction_func]
        type = FunctionNeumannBC
        variable = disp_x
        boundary = right
        function = 125*t
    []
    [fix_x]
        type = DirichletBC
        variable = disp_x
        boundary = left
        value = 0
    []
    [fix_y]
        type = DirichletBC
        variable = disp_y
        boundary = left
        value = 0
    []
    [fix_z]
        type = DirichletBC
        variable = disp_z
        boundary = left
        value = 0
    []
[]

[Materials]
    [elasticity]
        type = ComputeIsotropicElasticityTensor
        youngs_modulus = 3e7
        poissons_ratio = 0.3
    []
    [stress]
        type = ComputeLinearElasticStress
    []
[]

[Executioner]
    type = Transient
    num_steps = 10
    dt = 0.1
    solve_type = PJFNK
    petsc_options_iname = '-pc_type -pc_hypre_type'
    petsc_options_value = 'hypre boomeramg'
  []

[Outputs]
    [debug] # This is a test, use the [Debug] block to enable this
      type = VariableResidualNormsDebugOutput
    []
    exodus = true
    solution_history = true
  []