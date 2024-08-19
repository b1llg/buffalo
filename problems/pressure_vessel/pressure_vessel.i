# Model info
# Pressure vessel
#   pressure applied to the intenal face
# units: in, lbf, s, F

[GlobalParams]
    displacements = 'disp_x disp_y disp_z'
[]

[Mesh]
    # Read in mesh from file
    type = FileMesh
    file = pressure_vessel.e
[]

[Physics]

    [SolidMechanics]

        [QuasiStatic]
            # Parameters that apply to all subblocks are specified at this level.
            # They can be overwritten in the subblocks.
            add_variables = true
            incremental = false
            strain = SMALL
            generate_output = 'vonmises_stress'
            [block]
                block = 1
            []
        []
    []
[]

[BCs]
    [Pressure]
        [load]
            boundary = pressure_face
            factor = 5 # psi
            # Pressure applied is 5 psi
            # s_hoop = P*d/(2*t)
            # s_hoop = 5*200/(2*3)
            # s_hoop = 1000/6
            # s_hoop = 166 psi
            # s_z = P*d/(4*t)
            # s_z = 5*200/(4*3)
            # s_z = 83 psi
            # s_vm = 143.8
        []
    []
    [symmetry_x]
        # Applies symmetry on the xmin faces
        type = DirichletBC
        variable = disp_x
        boundary = side_x
        value = 0.0
    []
    [hold_z]
        # Anchors the bottom against deformation in the z-direction
        type = DirichletBC
        variable = disp_z
        boundary = bottom
        value = 0.0
    []
    [symmetry_y]
        # Applies symmetry on the ymin faces
        type = DirichletBC
        variable = disp_y
        boundary = side_y
        value = 0.0
    []
[]

[Materials]
    [elasticity_tensor_steel]
        # Creates the elasticity tensor using steel parameters
        youngs_modulus = 3e7 #psi
        poissons_ratio = 0.3
        type = ComputeIsotropicElasticityTensor
        block = 1
    []
    [stress]
        # Computes the stress, using linear elasticity
        type = ComputeLinearElasticStress
        block = 1
    []
[]

[Preconditioning]
    [SMP]
        type = SMP
        full = true
    []
[]

[Executioner]
    type = Steady

    solve_type = 'NEWTON'

    petsc_options = '-snes_ksp_ew'
    petsc_options_iname = '-pc_type -sub_pc_type -pc_asm_overlap -ksp_gmres_restart'
    petsc_options_value = 'asm lu 1 101'
[]

[Outputs]
    exodus = true
    perf_graph = true
[]