## Computing the matrix inverse is a computational heavy operation, especially
## for large matrices.  To speed up processing this file contains two functions
## that provide the ability to cache the inverse of a matrix. If the contents of
## a matrix do not change, then the inverse is looked up in the cache rather 
## than recomputed.

## makeCacheMatrix() - creates a user-defined square matrix that caches
## it's inverse.  Square matrix is assumed to be invertible
## the function will return a list of helper functions
##    set() - sets up the square matrix
##    get() - returns the sqare matrix
##    setInverse() - caches the inverse of the square matrix
##    getInverse() - returns the cache inverse of the square matrix
##

makeCacheMatrix <- function(x = matrix()) {
    ## function parameters:
    ##   x - square, invertible matrix
    
    ## initialize cache location on initial call
    m <- NULL
    
    ## create the set() helper function
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    
    ## create the get() helper function
    get <- function() x
    
    ## create the setInverse() helper function
    setInverse <- function(solve) m <<- solve
    
    ## create the getInverse() helper function
    getInverse <- function() m
    
    ## return the list of helper functions
    list(set = set, get = get,
         setInverse = setInverse,
         getInverse = getInverse)

}


## cacheSolve() - return matrix inverse of the user-defined matrix 

cacheSolve <- function(x, ...) {
    ## function parameters:
    ##   x - list of helper functions created by makeCacheMatrix() function
    
    ## get cached inverse of the specified matrix
    m <- x$getInverse()
    
    ## if the cache inverse is available, return the cached value
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    
    ## if cache is not availalbe, compute matrix inverse
    data <- x$get()
    m <- solve(data, ...)
    
    ## cache the matrix inverse and return the inverse
    x$setInverse(m)
    m
}

