<?php

use Acme\Demo\Math;

class MathTest extends PHPUnit_Framework_TestCase
{
    public function testAdd()
    {
        // Arrange
        $a = new Math();

        // Act
        $b = $a->add(2,3);

        // Assert
        $this->assertEquals(5, $b);
    }
}