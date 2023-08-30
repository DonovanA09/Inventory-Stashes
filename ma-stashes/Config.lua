Config = {}

Config.JobStashs = { -- Only people with a certain job can access this
    ['LSPD Stash'] = {
        label = "LSPD", --Keep this together to ensure greater order.
        coords = vector3(315.4593, -208.8400, 54.0863),
        Stash = {
            personal = false, -- establish whether its personal or not
            msg = 'E - Open LSPD Stash', -- Text 3D
            job = 'police', -- Job required
            grade = 3, -- Access to all ranks greater than or equal to 3 or 'all' for all
        },
    },
    ['LSPD Personal'] = {
        name = "LSPDPersonal",
        coords = vector3(317.2892, -204.7118, 54.0863),
        Stash = {
            personal = true,
            msg = 'E - Open LSPD Personal',
            job = 'police',
            grade = 'all',
        },
    },
}

Config.PublicStashs = { -- All people can access this.
    ['My Stash'] = {
        label = "MyStash",
        coords = vector3(332.1041, -203.5762, 54.0863),
        Stash = {
            personal = false,
            msg = 'E - Open My Stash',
        },
    },
    ['My Stash Personal'] = {
        label = "MyStashPersonal",
        coords = vector3(318.2126, -199.1588, 54.0863),
        Stash = {
            personal = true,
            msg = 'E - Open My Stash Personal',
        },
    },
}