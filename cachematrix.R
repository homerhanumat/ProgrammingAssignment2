## This pair of functions allows the user to create a matrix-like object and to
## cache the result of computing the inverse of this object.  Read the coments
## below to learn how they work, and consult the file example.md
## (in this repo) for an illustrative example.



#########################################################################################
## The function makeCacheMatrix() below takes a matrix as input and creates a list, one element of
## which is a function that returns the matrix.  Thus the output of this
## function is an object that is related ot the given matrix.  The list contains
## other elements that control the cache process.  See the  body of the code for
## more details.

makeCacheMatrix <- function(x = matrix()) {
  
  # we are just now making the object, so we have not computed the 
  # inverse of the matrix yet.  This fact is registered by setting `inv` to NULL:
  inv <- NULL
  
  # the following function will be the first element of the list.  It allows the user to
  # set new matrix values for the matrix-, after the matrix-like
  # object is created.
  set <- function(y) {  # y is the "next" matrix that the user would like to work with
    x <<- y  # this makes the get() function (defined below) reutrn the new matrix
    inv <<- NULL # since the matrix is new, it might be different from the
                 # previous once, so any inverse that has already been computed
                 # may not be the correct.  Record this fact by setting inv to NULL.
  }
  
  # the following function will be the second element of the list.  From it the user can learn
  # the value fo the current matrix.
  get <- function() x
  
  # the following function will be the third element of the list.  Thr cacheSolve()
  # function (defined below) will use it to store the inverse of the new matrix in the list.
  # Thus this is, in essence, the cache.
  setinverse <- function(inverse) inv <<- inverse
  
  # The following function will be the fourth and final element of the list.
  # The user could use it to get the latest inverse, but really iut's here so that
  # the cacheSolve() function can use it to see if the inverse has already been computed
  getinverse <- function() inv
  
  # now we make the list and return it:
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}



#########################################################################################
## This function takes as input a list that was created by a previous call to
## makeCacheMatrix() and checks to see if the inverse of the matrix has already been
## computed.  If the inverse has been computed, it returns the cached inverse.
## If not, it computes the inverse, stores it in the cache and returns the
## inverse to the user.  See the body of the code for more details.

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  
  # First check the cache to see if the inverse has already been computed:
  inv <- x$getinverse()
  if(!is.null(inv)) { # The inverse has been computed alreadY!
    message("getting cached data") # Inform the user of this ...
    return(inv)                    # ... and give the user the inverse, then get out of the function.
  }
  
  # If we are this far into the function, then no inverse has been computed yet.
  
  # So, we get the matrix out of the list:
  data <- x$get()
  
  #  Then we compute its inverse:
  inv <- solve(data, ...)
  
  # Then we store the inverse in the cache
  x$setinverse(inv)
  
  # Finally, we return the inverse ot the user.
  inv
}
