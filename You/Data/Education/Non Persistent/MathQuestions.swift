//
//  MathQuestions.swift
//  You
//
//  Created by Oliver Gilcher on 2/3/25.
//

final class MathQuestions : Identifiable {
    final var easy: [String: String] = [
        "5 + 7" : "12",
        "18 - 9" :  "9",
        "6 × 3" : "18",
        "24 ÷ 6" : "4",
        "9 + 8" : "17",
        "14 - 7" : "7",
        "8 × 2" : "16",
        "36 ÷ 4" : "9",
        "10 + 15" : "25",
        "20 - 5" : "15",
        "7 × 5" : "35",
        "49 ÷ 7" : "7",
        "25 + 6" : "31",
        "30 - 12" : "18",
        "4 × 9" : "36",
        "81 ÷ 9" : "9",
        "11 + 3" : "14",
        "50 - 20" : "30",
        "12 × 2" : "24",
        "100 ÷ 10" : "10",
        "15 + 6" : "21",
        "28 - 4" : "24",
        "6 × 7" : "42",
        "45 ÷ 5" : "9",
        "8 + 13" : "21"
    ]
    
    final var medium: [String : String] = [
        "144 ÷ 12" : "12",
        "32 ÷ 8" : "4",
        "17 + 24" : "41",
        "56 - 19" : "37",
        "13 × 5" : "65",
        "90 ÷ 6" : "15",
        "7²" : "49",
        "√81" : "9",
        "5³" : "125",
        "√225" : "15",
        "(12 + 8) ÷ 4" : "5",
        "(50 - 20) × 2" : "60",
        "(3 × 5) + (7 × 2)" : "29",
        "16 × 4 - 10" : "54",
        "(9 + 3) × 2" : "24",
        "(100 ÷ 5) + 12" : "32",
        "(20 + 15) ÷ 5" : "7",
        "3 × (4 + 5)" : "27",
        "(6² + 4) ÷ 2" : "20",
        "45 ÷ (3 + 6)" : "5",
        "(5 + 10) × 2 - 4" : "26",
        "(8 × 7) ÷ 2" : "28",
        "100 - (10 × 5)" : "50",
        "4³ ÷ 2" : "32",
        "√64 × 3" : "24"
    ]
    
    final var hard: [String : String] = [
        "2(3x - 5) = 10\nsolve for x" : "x = 5",
        "4x + 7 = 3x + 10\nSolve for x" : "x = 3",
        "5(x - 2) = 3x + 4\nSolve for x" : "x = 7",
        "3x/2 - 5 = 4\nSolve for x" : "x = 6",
        "7x + 3 = 2x + 18\nSolve for x" : "x = 3",
        "2(x + 4) = 3(x - 2)\nSolve for x" : "x = 10",
        "9x - 4 = 2x + 17\nSolve for x" : "x = 3",
        "5(x - 3) = 2(x + 6)\nSolve for x" : "x = 7",
        "3(x + 2) = 2(x + 5)\nSolve for x" : "x = 4",
        "6(x - 1) = 2x + 8\nSolve for x" : "x = 3",
        "x² - 5x + 6 = 0\nSolve for x" : "x = 2, x = 3",
        "x² - 4x - 5 = 0\nSolve for x" : "x = 5, x = -1",
        "x² + 6x + 9 = 0\nSolve for x" : "x = -3",
        "2x² - 8x + 6 = 0\nSolve for x" : "x = 1, x = 3",
        "x² - 16 = 0\nSolve for x" : "x = 4, x = -4",
        "3x² - 12x + 9 = 0\nSolve for x" : "x = 1, x = 3",
        "x² + x - 12 = 0\nSolve for x" : "x = 3, x = -4",
        "x² - 2x - 15 = 0\nSolve for x" : "x = 5, x = -3",
        "x² + 4x - 21 = 0\nSolve for x" : "x = 3, x = -7",
        "x² - 9x + 18 = 0\nSolve for x" : "x = 3, x = 6",
        "x² + 5x - 24 = 0\nSolve for x" : "x = -8, x = 3",
        "x² - 7x + 12 = 0\nSolve for x" : "x = 3, x = 4",
        "x² - x - 20 = 0\nSolve for x" : "x = 5, x = -4",
        "x² - 6x + 8 = 0\nSolve for x" : "x = 2, x = 4",
        "4x² - 16 = 0\nSolve for x" : "x = 2, x = -2"
    ]
    
    final var expert: [String : String] = [
        "√(x + 4) = 3\nSolve for x" : "x = 5",
        "3^(x + 1) = 27\nSolve for x" : "x = 2",
        "log₂(x) = 5\nSolve for x" : "x = 32",
        "2^x = 16\nSolve for x" : "x = 4",
        "ln(x) = 1\nSolve for x" : "x ≈ 2.718",
        "e^(x - 1) = 7\nSolve for x" : "x = ln(7) + 1",
        "sin(x) = 1/2\nSolve for x in [0, 2π]" : "x = π/6, 5π/6",
        "cos(x) = -√3/2\nSolve for x in [0, 2π]" : "x = 5π/6, 7π/6",
        "tan(x) = 1\nSolve for x in [0, 2π]" : "x = π/4, 5π/4",
        "2sin(x) - 1 = 0\nSolve for x in [0, 2π]" : "x = π/6, 5π/6",
        "x³ - 27 = 0\nSolve for x" : "x = 3",
        "x^4 - 16 = 0\nSolve for x" : "x = ±2",
        "πx = 180\nSolve for x" : "x = 180/π",
        "x! = 6\nSolve for x" : "x = 3",
        "∫(2x)dx from 0 to 3\nEvaluate the integral" : "9",
        "d/dx (x²e^x)\nFind the derivative" : "(2x + x²)e^x",
        "lim x→∞ (3x² + x)/(x² - 1)\nFind the limit" : "3",
        "∑(n=1 to ∞) 1/n²\nFind the sum" : "π²/6",
        "x² + y² = 25\nFind the radius" : "r = 5",
        "(3 + 4i)(2 - i)\nMultiply and simplify" : "6 + 8i - 3i - 4i² = 10 + 5i"
    ]
    
    func getQuestionType(difficulty: String) -> [String : String] {
        let difficulty = difficulty.lowercased()
        
        switch (difficulty) {
        case "easy" : return easy
        case "medium": return medium
        case "hard": return hard
        case "expert": return expert
        default: return easy
        }
    }
}
