# if statement
x <- 10
if (x > 7) {
  print("x is greater than 7")
}

# if..else staement
x <- 4
if (x > 6) {
  print("x is greater than 6")
} else {
  print("x is 6 or less")
}

#if..else if..else Ladder
score <- 85
if (score >= 90) {
  print("Grade A")
} else if (score >= 80) {
  print("Grade B")
} else if (score >= 70) {
  print("Grade C")
} else {
  print("Grade F")
}

#for Loop
for (i in 5:10) {
  print(paste("Iteration", i))
}

#repeat Loop (with break)
i <- 1
repeat {
  print(i)
  i <- i + 1
  if (i > 10) break
}

#next Statement (skip to next iteration)
for (i in 1:10) {
  if (i == 5) next
  print(i)
}

#break Statement (exit the loop)
for (i in 1:10) {
  if (i == 5) break
  print(i)
}

#Build-in Function
#mean()
numbers <- c(10, 20, 30, 40, 50,60,70,80,90)
mean(numbers)
sum(numbers)
length(numbers)

#round()
pi_val <- 3.14159
round(pi_val, 2)

paste("Hello", "World")

#User-define Function
#Simple function to add two numbers
add_numbers <- function(a, b) {
  return(a + b)
}
add_numbers(6, 4)

#Function to check if a number is even
is_even <- function(x) {
  if (x %% 2 == 0) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

is_even(6)

#Function with default parameter
greet <- function(name = "User") {
  paste("Hello", name)
}
greet()

greet("Abir")

#Anonymous (Lambda) Function with sapply()
numbers <- 1:10
squared <- sapply(numbers, function(x) x^2)
print(squared)

#Data Read
#Reading a CSV File
data <- read.csv("~/Downloads/sample_dataset.csv")
head(data)  # View the first few rows

#Reading a Text File (tab-delimited)
data <- read.table("~/Downloads/sample_tab_delimited.txt", header = TRUE, sep = "\t")
head(data)

#Reading Data from a URL
url <- "https://raw.githubusercontent.com/uiuc-cse/data-fa14/gh-pages/data/iris.csv"
data <- read.csv(url)
head(data)