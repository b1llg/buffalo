[GlobalParams]
    displacements = 'disp_x disp_y disp_z'
    volumetric_locking_correction = true
[]

[Mesh]
    [mesh]
        type = GeneratedMeshGenerator
        dim = 3
        nx = 5
        ny = 5
        nz = 5
        elem_type = HEX8
    []
    [extra_nodeset]
        type = ExtraNodesetGenerator
        input = mesh
        new_boundary = 'master'
        coord = '1.0 1.0 1.0'
    []
[]

[Physics]

    [SolidMechanics]

        [QuasiStatic]
            [all]
                add_variables = true
                generate_output = 'vonmises_stress'
                strain = SMALL
            []
        []
    []
[]

[Functions]
    [function_pull]
        type = PiecewiseLinear
        x = '0 100'
        y = '0 0.1'
    []
[]

# [Constraints]
#     [one]
#         type = LinearNodalConstraint
#         variable = disp_x
#         primary = '6'
#         secondary_node_ids = '1 2 5'
#         penalty = 1.0e8
#         formulation = kinematic
#         weights = '1'
#     []
#     [two]
#         type = LinearNodalConstraint
#         variable = disp_z
#         primary = '6'
#         secondary_node_ids = '4 5 7'
#         penalty = 1.0e8
#         formulation = kinematic
#         weights = '1'
#     []
# []

[BCs]
    [symmy]
        type = DirichletBC
        variable = disp_y
        boundary = bottom
        value = 0
    []
    [symmx]
        type = DirichletBC
        variable = disp_x
        boundary = left
        value = 0
    []
    [symmz]
        type = DirichletBC
        variable = disp_z
        boundary = back
        value = 0
    []
    # What's done below is to capture the weird constraints
    [axial_load]
        type = FunctionDirichletBC
        variable = disp_y
        boundary = 'top'
        function = function_pull
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
[Preconditioning]
    [smp]
        type = SMP
        full = true
    []
[]

[Executioner]
    type = Transient

    l_max_its = 100
    l_tol = 1e-8
    nl_max_its = 50
    nl_rel_tol = 1e-8
    nl_abs_tol = 1e-8

    dtmin = 1
    dt = 5
    end_time = 100
[]

[Outputs]
    exodus = true
[]