if [ -z $2 ]
then
exit
fi
mkdir $1
mkdir $1/interface
mkdir $1/service
sed 's/home/'$1'/g; s/Home/'$2'/g;' <home/interface/HomeCoordinatorType.swift >$1/interface/$2CoordinatorType.swift
sed 's/home/'$1'/g; s/Home/'$2'/g;' <home/interface/HomeModule.swift >$1/interface/$2Module.swift
sed 's/home/'$1'/g; s/Home/'$2'/g;' <home/service/HomeModuleAssembly.swift >$1/service/$2ModuleAssembly.swift
sed 's/home/'$1'/g; s/Home/'$2'/g;' <home/service/HomeCoordinator.swift >$1/service/$2Coordinator.swift
