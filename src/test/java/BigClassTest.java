import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class BigClassTest {
    @Test
    void TheBigTest() {
        BigClass big1 = new BigClass();
        BigClass big2 = new BigClass();
        assertEquals(big1.number,big2.number);
        assertEquals(big1.text,big2.text);
    }
    @Test
    void constructorOne() {
        BigClass big1 = new BigClass(31);
        assertEquals(31, big1.number);

    }
    @Test
    void constructorTwo() {
        BigClass big2 = new BigClass("Tjena");
        assertEquals("Tjena", big2.text);
    }
    @Test
    void constructorThree() {
        BigClass big3 = new BigClass(31, "Tjena");
        assertEquals(31, big3.number);
        assertEquals("Tjena", big3.text);
    }
    @Test
    void negativeNumber() {
        BigClass big = new BigClass();
        big.setNumber(-5);
        assertEquals(0, big.getNumber());
    }
    @Test
    void testText () {
        BigClass big = new BigClass();
        big.setText("Hej");
        assertEquals("Hej", big.getText());
    }
    @Test
    void upperCase() {
        BigClass big = new BigClass();
        assertEquals("HOLA", big.textToUpperCase("hola"));
    }
    @Test
    void textNullText() {
        BigClass big = new BigClass("hej");
        assertEquals(null, big.textToNullMethod());
    }
    @Test
    void numberAgain() {
        BigClass big = new BigClass(56);
        big.sumOfNumber(20);
        assertEquals(76, big.getNumber());
    }
    @Test
    void stringTextTest() {
        BigClass big = new BigClass(90, "hola!");
        assertEquals("number=90, text=hola!", big.toString());
    }

}