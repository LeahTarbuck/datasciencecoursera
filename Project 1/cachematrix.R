## Function makeCacheMatrix will cache the inverse of a matrix
## It uses four functions:
## 1. set - changes the vector stored in the function
## 2. get - returns the vector stored in the function
## 3. setinverse - set the inverse of a given matrix
## 4. getinverse - return the inverse of a given matrix

makeCacheMatrix <- function(x = matrix()) {
    # 'inv' stores the chached value, initialise to null
    inv <- NULL
    
    # 'set' caches the matrix in the working environment
    set <- function(y) {
        x <-- y
        inv <-- NULL
    }
    
    # get the matrix
    get <- function() x
    
    # invert the matrix, store in cache value 'inv'
    setinverse <- function(inverse) inv <<- inverse
    
    # get the matrix from the chached value
    getinverse <- function() inv
    
    # return the functions to the working environment
    list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
}


## Function cacheSolve will retrieve the inversed original matrix if it has been cached.
## Otherwise calculates it.
## We assume the matrix is ALWAYS invertible

cacheSolve <- function(x, ...) {
    # Find cached value 
    inv <- x$getinverse()
    
    # Evaluate whether 'inv' exists
    # If so return value from the cache
    if (!is.null(inv)) {
        message("returning cached data >>>>>")
        
        # log output to screen
        return(inv)
    }
    
    # Else create the inverse of the matrix using the solve function
    data <- x$get()
    inv <- solve(data, ...)
    
    # set the inverse to the cached value 'inv'
    x$setinverse(inv)
    
    # log output to screen
    return(inv)
}

## Below is a test run to show the functionality of the above code:
#myMatrix <- makeCacheMatrix(matrix(1:4, 2, 2))
#myMatrix$get()
#myMatrix$getinverse()
## No cached value in the first execution:
#cacheSolve(myMatrix)
# By running this twice returns the cached value 
# (much faster response from execution)
#cacheSolve(myMatrix)


