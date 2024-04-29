#ifndef BIGINT_H
#define BIGINT_H
#include <cstdint>
#include <stdexcept>
class UBigInt {

public:
  typedef enum {
    BIGINT_ERROR_NONE,
    BIGINT_ERROR_UNDERFLOW,
    BIGINT_ERROR_OVERFLOW,
    BIGINT_ERROR_UNDEFINED,
    BIGINT_ERROR_COUNT
  } BIGINT_E;
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
    UBigInt res = UBigInt(a); // TODO: TOIJSOIJ
    res += *this;
    return res;
  }
  void operator+=(const UBigInt &a) noexcept(false) {
    this->rhs += a.rhs;
    if (this->rhs < a.rhs) {
      this->lhs++; // carry
    }
    this->lhs += a.lhs;
    if (*this < a) {
      throw std::overflow_error(
          "unsigned addition resulted in smaller number.");
    }
  }
  UBigInt operator-(const UBigInt &a);
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

private:
  uint64_t lhs;
  uint64_t rhs;
  BIGINT_E err;
};

#endif // !BIGINT_H
