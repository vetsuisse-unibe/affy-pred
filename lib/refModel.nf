def createMap (String modelsFile) {
    file = new File(modelsFile)
    def modelsMap = file.readLines().inject([:]) { map, line ->
        def parts = line.split('/')
        def key = parts[1] //species
        def type = parts[2] // RBF or TF
        def value = parts[3] //model
        if (map.containsKey(key)) { //Map contains species
            if(map[key].containsKey(type)) { //Map contains type for that species ?
                map[key][type] << value // yes, so append to the array of models
            } else {
                map[key][type] = [value] // no, create new array of models
            }
        } else { //Map doesn't contains species
            map[key] = [:] //create an empty Map for species
            map[key][type] = [value] //add nested Map of model type and model name
        }
        map
    }
    
}

def refGenome (String value, String refdb) {
    def refParams=[]
    new File(refdb).eachLine { line ->
        def fields = line.split(";")
        if (fields[0] == value ){
            refParams << fields[1]
            refParams << fields[2]
        }

    }
    return refParams
}

