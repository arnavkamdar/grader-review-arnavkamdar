CPATH='.;../lib/junit-4.13.2.jar;../lib/hamcrest-core-1.3.jar'


rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission
if [[ -f ListExamples.java ]]
then
    echo "found ListExamples.java!"
    else 
        echo "did not find file"
        exit 1
fi

cat ListExamples.java > class.txt
if grep -Fq "class ListExamples {" class.txt
then
    echo "found Class ListExamples"
    else
        echo "did not find class" 
        exit 2
fi


if grep -Fq "static List<String> filter(List<String> list, StringChecker sc)" class.txt
then
    echo "found filter method!"
    else 
        echo "did not find filter method"
        exit 2
fi


if grep -Fq "static List<String> merge(List<String> list1, List<String> list2)" class.txt
then
    echo "found merge method!"
    else 
        echo "did not find merge method"
        exit 2
fi


cp ../TestListExamples.java 'TestListExamples.java'


javac -cp $CPATH *.java
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > out.txt 2>&1


if grep -Fq "OK" out.txt
then
    echo "You passed!"
    else echo "$(cat out.txt)"
        exit 3
fi
