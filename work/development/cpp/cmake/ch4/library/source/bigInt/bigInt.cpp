#ifndef BIGINT_H
#define BIGINT_H
#include "bigInt.h"
#include <cstdint>
#include <stdexcept>
class UBigInt {

private:
  uint64_t lhs;
  uint64_t rhs;
  BIGINT_E err;
};

public:
  UBigInt() {
    this->lhs = 0;
    this->rhs = 0;
  }
  UBigInt(uint64_t lhs, uint64_t rhs);
  UBigInt(const UBigInt &a) {
    this->lhs = a.lhs;
    this->rhs = a.rhs;
  }
  ~UBigInt();
  UBigInt operator+(const UBigInt &a) {
    UBigInt res = UBigInt(a); 
    res += *this;
    return res;
  }
  void operator+=(const UBigInt &a) {
    this->rhs += a.rhs;
    if (this->rhs < a.rhs) {
      this->lhs++; // carry
    }
    this->lhs += a.lhs;
    if (*this < a) {
      this->err = BIGINT_ERROR_OVERFLOW;
    }
  }
  UBigInt operator-(const UBigInt &a)
  {
    UBigInt res = UBigInt(this);
    if(this < &a) {
      res.err = BIGINT_ERROR_UNDERFLOW;
    }
    else {
      res.lhs -= a.lhs;
      if(a.rhs > res.rhs) {{
        res.lhs--;
      }
      res.rhs -= a.rhs;
    }
  return res;
    
  }
  void operator-=(const UBigInt &a) noexcept(false);
  UBigInt operator*(const UBigInt &a);
  void operator*=(const UBigInt &a) noexcept(false);
  UBigInt operator/(const UBigInt &a);
  void operator/=(const UBigInt &a) noexcept(false);
  bool operator!=(const UBigInt &a);
  bool operator==(const UBigInt &a);
  bool operator<=(const UBigInt &a);
  bool operator>=(const UBigInt &a);
  bool operator<(const UBigInt &a);
  bool operator>(const UBigInt &a);
  BIGINT_E get_error() { return this->err; }

#endif // !BIGINT_H
