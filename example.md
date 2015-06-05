## Example of Use

Make sure you load the functions:

```
source("cachematrix.R")
```

First, let's make a small invertible matrix:

```
mat <- matrix(c(1,2,2,2),2,2)
```

Let's get its inverse the usual way:

```
solve(mat)
```

We get:

```
#      [,1] [,2]
# [1,]   -1  1.0
# [2,]    1 -0.5
```

Now let's make the matrix-like list:

```
a <- makeCacheMatrix(x = mat)
```

You can get the value of the matrix from this list:

```
a$get()

#      [,1] [,2]
# [1,]    1    2
# [2,]    2    2
```

If you run the following command ...

```
a$getinverse()
```

... then you get NULL, because the inverse has not been computed yet.

Now let's compute the inverse:

```
cacheSolve(a)

#      [,1] [,2]
# [1,]   -1  1.0
# [2,]    1 -0.5
```

Let's check to see that this computation has been registered in the list:

```
a$getinverse()
```

```
#      [,1] [,2]
# [1,]   -1  1.0
# [2,]    1 -0.5
```

Yup, there it is!

If we find the inverse again, the function will pull the inverse from the cache:

```
cacheSolve(a)

getting cached data
#      [,1] [,2]
# [1,]   -1  1.0
# [2,]    1 -0.5
```

If we create the list again (even from the same matrix), the cache is wiped:

```
a <- makeCacheMatrix(x = mat)
a$getinverse()

# NULL
```



