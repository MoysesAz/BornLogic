import Foundation

protocol ViewCoding {
    func setAllConstraints()
    func setHierarchy()
}

extension ViewCoding {
    func buildLayout(){
        setHierarchy()
        setAllConstraints()
    }
}
