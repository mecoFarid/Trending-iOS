// MARK: - Mocks generated from file: Trending/Common/Data/Datasource.swift at 2022-12-21 18:56:59 +0000

//
//  Datasource.swift
//  Trending
//
//  Created by Farid Mammadov on 01.12.22.
//

import Cuckoo
@testable import Trending

import Foundation






 class MockDatasource<T, E: DataException>: Datasource, Cuckoo.ProtocolMock {
    
     typealias MocksType = DefaultImplCaller<T, E>
    
     typealias Stubbing = __StubbingProxy_Datasource
     typealias Verification = __VerificationProxy_Datasource

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
     class DefaultImplCaller<T, E: DataException>: Datasource {
        private let reference: Any
    
        
        
        init<_CUCKOO$$GENERIC: Datasource>(from defaultImpl: UnsafeMutablePointer<_CUCKOO$$GENERIC>, keeping reference: @escaping @autoclosure () -> Any?) where _CUCKOO$$GENERIC.T == T, _CUCKOO$$GENERIC.E == E {
            self.reference = reference
    
            
            _storage$1$get = defaultImpl.pointee.get
            _storage$2$put = defaultImpl.pointee.put
            
        }
        
        
    
        
        private let _storage$1$get: (Query) -> Result<T, E>
         func get(query: Query) -> Result<T, E> {
            return _storage$1$get(query)
        }
        
        private let _storage$2$put: (Query, T) -> Result<T, E>
         func put(query: Query, data: T) -> Result<T, E> {
            return _storage$2$put(query, data)
        }
        
    }

    private var __defaultImplStub: DefaultImplCaller<T, E>?

     func enableDefaultImplementation<_CUCKOO$$GENERIC: Datasource>(_ stub: _CUCKOO$$GENERIC) where _CUCKOO$$GENERIC.T == T, _CUCKOO$$GENERIC.E == E {
        var mutableStub = stub
        __defaultImplStub = DefaultImplCaller(from: &mutableStub, keeping: mutableStub)
        cuckoo_manager.enableDefaultStubImplementation()
    }

     func enableDefaultImplementation<_CUCKOO$$GENERIC: Datasource>(mutating stub: UnsafeMutablePointer<_CUCKOO$$GENERIC>) where _CUCKOO$$GENERIC.T == T, _CUCKOO$$GENERIC.E == E {
        __defaultImplStub = DefaultImplCaller(from: stub, keeping: nil)
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     func get(query: Query) -> Result<T, E> {
        
    return cuckoo_manager.call(
    """
    get(query: Query) -> Result<T, E>
    """,
            parameters: (query),
            escapingParameters: (query),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.get(query: query))
        
    }
    
    
    
    
    
     func put(query: Query, data: T) -> Result<T, E> {
        
    return cuckoo_manager.call(
    """
    put(query: Query, data: T) -> Result<T, E>
    """,
            parameters: (query, data),
            escapingParameters: (query, data),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.put(query: query, data: data))
        
    }
    
    

     struct __StubbingProxy_Datasource: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func get<M1: Cuckoo.Matchable>(query: M1) -> Cuckoo.ProtocolStubFunction<(Query), Result<T, E>> where M1.MatchedType == Query {
            let matchers: [Cuckoo.ParameterMatcher<(Query)>] = [wrap(matchable: query) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockDatasource.self, method:
    """
    get(query: Query) -> Result<T, E>
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func put<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(query: M1, data: M2) -> Cuckoo.ProtocolStubFunction<(Query, T), Result<T, E>> where M1.MatchedType == Query, M2.MatchedType == T {
            let matchers: [Cuckoo.ParameterMatcher<(Query, T)>] = [wrap(matchable: query) { $0.0 }, wrap(matchable: data) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockDatasource.self, method:
    """
    put(query: Query, data: T) -> Result<T, E>
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_Datasource: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func get<M1: Cuckoo.Matchable>(query: M1) -> Cuckoo.__DoNotUse<(Query), Result<T, E>> where M1.MatchedType == Query {
            let matchers: [Cuckoo.ParameterMatcher<(Query)>] = [wrap(matchable: query) { $0 }]
            return cuckoo_manager.verify(
    """
    get(query: Query) -> Result<T, E>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func put<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(query: M1, data: M2) -> Cuckoo.__DoNotUse<(Query, T), Result<T, E>> where M1.MatchedType == Query, M2.MatchedType == T {
            let matchers: [Cuckoo.ParameterMatcher<(Query, T)>] = [wrap(matchable: query) { $0.0 }, wrap(matchable: data) { $0.1 }]
            return cuckoo_manager.verify(
    """
    put(query: Query, data: T) -> Result<T, E>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class DatasourceStub<T, E: DataException>: Datasource {
    

    

    
    
    
    
     func get(query: Query) -> Result<T, E>  {
        return DefaultValueRegistry.defaultValue(for: (Result<T, E>).self)
    }
    
    
    
    
    
     func put(query: Query, data: T) -> Result<T, E>  {
        return DefaultValueRegistry.defaultValue(for: (Result<T, E>).self)
    }
    
    
}




