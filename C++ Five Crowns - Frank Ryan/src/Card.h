#pragma once
#include <string>
#include <iostream>
#include <sstream>
#include <iostream>
using std::string;
class Card
{
public:
	
	Card(string val, string suite, int deckNumber);
	string getVal();
	int getNumValue();
	string getSuite();
	int getDeck();

	
	bool getWild(int round);
	

	bool operator ==(Card &one)
	{
		if (value == "X")
		{
			if (one.getNumValue() == 10)
			{
				return true;
			}
			return false;
		}
		if (value == "J" && (suite == "1" || suite == "2" || suite == "3"))
		{
			if (one.getNumValue() == 50)
			{
				return true;
			}
			return false;
		}
		if (value == "J")
		{
			if (one.getNumValue() == 11)
			{
				return true;
			}
			return false;
		}
		if (value == "Q")
		{
			if (one.getNumValue() == 12)
			{
				return true;
			}
			return false;
		}
		if (value == "K")
		{
			if (one.getNumValue() == 13)
			{
				return true;
			}
			return false;
		}
		
		else if (one.getNumValue() == stoi(value))
		{
			return true;
		}
		return false;
	}
	bool operator >(Card &one)
	{
		if (value == "X")
		{
			if (one.getNumValue() < 10)
			{
				return true;
			}
			return false;
		}
		if (value == "J" && (suite == "1" || suite == "2" || suite == "3"))
		{
			if (one.getNumValue() < 50)
			{
				return true;
			}
			return false;
		}
		if (value == "J")
		{
			if (one.getNumValue() < 11)
			{
				return true;
			}
			return false;
		}
		if (value == "Q")
		{
			if (one.getNumValue() < 12)
			{
				return true;
			}
			return false;
		}
		if (value == "K")
		{
			if (one.getNumValue() < 13)
			{
				return true;
			}
			return false;
		}
	
		else if(one.getNumValue() < stoi(value))
		{
			return true;
		}
		return false;
	}
	bool operator <(Card &one)
	{
		if (value == "X")
		{
			if (one.getNumValue() > 10)
			{
				return true;
			}
			return false;
		}
		if (value == "J" && (suite == "1" || suite == "2" || suite == "3"))
		{
			if (one.getNumValue() > 50)
			{
				return true;
			}
			return false;
		}
		if (value == "J")
		{
			if (one.getNumValue() > 11)
			{
				return true;
			}
			return false;
		}
		if (value == "Q")
		{
			if (one.getNumValue() > 12)
			{
				return true;
			}
			return false;
		}
		if (value == "K")
		{
			if (one.getNumValue() > 13)
			{
				return true;
			}
			return false;
		}
		
		else if (one.getNumValue() > stoi(value))
		{
			return true;
		}
		return false;
	}
	bool operator !=(Card &one)
	{
		if (value == "X")
		{
			if (one.getNumValue() != 10)
			{
				return true;
			}
			return false;
		}
		if (value == "J" && (suite == "1" || suite == "2" || suite == "3"))
		{
			if (one.getNumValue() != 50)
			{
				return true;
			}
			return false;
		}
		if (value == "J")
		{
			if (one.getNumValue() != 11)
			{
				return true;
			}
			return false;
		}
		if (value == "Q")
		{
			if (one.getNumValue() != 12)
			{
				return true;
			}
			return false;
		}
		if (value == "K")
		{
			if (one.getNumValue() != 13)
			{
				return true;
			}
			return false;
		}
		
		else if (one.getNumValue() != stoi(value))
		{
			return true;
		}
		return false;
	}
	~Card();
private: 
	string suite;
	string value;
	int deckTag;

};

