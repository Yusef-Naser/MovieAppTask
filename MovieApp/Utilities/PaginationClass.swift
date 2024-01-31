//
//  PaginationClass.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

import Foundation



/**
 
 Example :
 
 let pagination = PaginationClass<String>()
 
 
    func callPagination (index : Int ) {
        if pagination.allowPagination(index: index) {
            callGetData()
        }
    }
 
    // when user wip to refresh
     func refreshData() {
         pagination.resetData()
         callGetData()
     }
 
 
    // get item in list
    func getItemInList ( index : Int  ) {
        let item =   pagination.listData[index]
    }
 
    func getData () {
            if  !( pagination.beforeCallService() ) {
                return
            }
            // call get data   ( page :  pagination.currentPage   )
            // get get data is success
            self.pagination.setDataPagination(listData : responseList  ,
                currentPage: data?.meta.currentPage ?? 1  ,
                lastPage: data?.meta.lastPage ?? 1  )
    }
 
 
 
 */


class PaginationClass <T> {
    
    var currentPage = 0
    var totalPages = 1
    var paginate : Bool = false
    var listData : [T] = []
    private var firstLoad = true
    
    
    func resetData() {
        listData = []
        currentPage = 0
        totalPages = 1
        paginate = false

        
    }
    
    
    func beforeCallService () -> Bool  {
        if currentPage >= totalPages {
            return false
        }
        if paginate {
            return false
        }
        paginate = true
        firstLoad = false
        currentPage += 1
        return true
    }
    
    func isFirstLoad () -> Bool {
        
        return firstLoad
    }
    
    func setDataPagination (listData : [T] , currentPage : Int , totalPages : Int  ) {
        self.paginate = false
        self.totalPages = totalPages
        self.currentPage = currentPage
        self.listData += listData
        firstLoad = false
    }
    
    
    func allowPagination (index : Int ) -> Bool {
        
        if currentPage >= totalPages {
            return false
        }
        
        if paginate {
            return false
        }

        if index == listData.count - 1 {
            return true
        }

        return false
    }
    
    
}
