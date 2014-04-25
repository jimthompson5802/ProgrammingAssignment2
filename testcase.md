Unit Test for Programming Assignment 2
========================================================

This is the documentation for the test cases for Programming Assignment 2.

Source Code
-----------

```r
## define cacheSolve() and makeCacheMatrix() functions
source("cachematrix.r", echo = TRUE)
```

```
## 
## > makeCacheMatrix <- function(x = matrix()) {
## +     m <- NULL
## +     set <- function(y) {
## +         x <<- y
## +         m <<- NULL
## +     }
## +     get <- f .... [TRUNCATED] 
## 
## > cacheSolve <- function(x, ...) {
## +     m <- x$getInverse()
## +     if (!is.null(m)) {
## +         message("getting cached data")
## +         return(m)
## +   .... [TRUNCATED]
```


Test Case 1
-----------
This test case shows the calculation of the matrix inverse


```r
## define test case matrix
mat <- makeCacheMatrix(matrix(1:4, ncol = 2))

## return matrix
mat$get()
```

```
##      [,1] [,2]
## [1,]    1    3
## [2,]    2    4
```

```r

## retrieve matrix inverse should not indicate getting value from cache
cacheSolve(mat)
```

```
##      [,1] [,2]
## [1,]   -2  1.5
## [2,]    1 -0.5
```

```r

## retrieve matrix inverse again should see message that marix is from cache
cacheSolve(mat)
```

```
## getting cached data
```

```
##      [,1] [,2]
## [1,]   -2  1.5
## [2,]    1 -0.5
```

```r


## multiple the matrix with its inverse this results in the identity matrix
mat$get() %*% cacheSolve(mat)
```

```
## getting cached data
```

```
##      [,1] [,2]
## [1,]    1    0
## [2,]    0    1
```



Test Case 2
-----------
This test case will show timing differences for large matrix


```r
## define large n-by-n square matrix
set.seed(1)
n <- 2500
mat <- makeCacheMatrix(matrix(sample(n^2), ncol = n))

## first-time retrieval of inverse
system.time(m1 <- cacheSolve(mat))
```

```
##    user  system elapsed 
##   15.88    0.06   15.99
```

```r

## second-time retrieval of inverse should be faster elapsed time should be
## less than the first-time retrieval
system.time(m2 <- cacheSolve(mat))
```

```
## getting cached data
```

```
##    user  system elapsed 
##       0       0       0
```

```r

## Test if first and second retrievals are the same this should return TRUE
identical(m1, m2)
```

```
## [1] TRUE
```


