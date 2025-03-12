%% Preparation of DataSet
%First we will prepare the dataset. We have taken a dataset of the canadian
%super store and we are going to prepare it such that each product has
%available price of four different retailers so that we can easily do price
%comparison
filepath = 'E:\FreeLance Projects\Project 5 Price Cacher System (MatLab)\products_data.csv';
Grocery_store_dataset = readtable(filepath);
Height_of_Column = height(Grocery_store_dataset.PricePerEach);
clc;
disp("######################################################################");
disp("Welcome to Price catcher System");
disp("######################################################################");
disp("**********************************************************************");

% Create a cell array containing sequential numbers from 1 to numRows
serialNumbers = num2cell((1:Height_of_Column)');
Feedback =  num2cell(ones(Height_of_Column,1)*5.0);
% Convert the cell array to a table with appropriate variable name
serialNumbersTable = cell2table(serialNumbers,'VariableNames' ,{'Serial_No'});
FeedbackTable = cell2table(Feedback,'VariableNames' ,{'Customer Feedback'});
% Concatenate the new table with the existing one
Grocery_store_dataset = [serialNumbersTable, Grocery_store_dataset];
Grocery_store_dataset = [Grocery_store_dataset,FeedbackTable];
Fav_Products = zeros(Height_of_Column,1);
Minimum_Prices = zeros(Height_of_Column,1);
New_Prices = zeros(Height_of_Column,1);
index = 1;
while(1)
    disp("**********************************************************************");
    disp("Select your option");
    disp("(1) Explore Products");
    disp("(2) Price Alerts");
    disp("(3) Customer Feedback");
    disp("(4) Quit");
    disp("**********************************************************************");

    Option = input("Select your option",'s');
    if (Option == '1')
        disp("Pls wait while we fetch prices of different products");
        RetailerA = string(zeros(Height_of_Column,1));
        RetailerB = string(zeros(Height_of_Column,1));
        RetailerC = string(zeros(Height_of_Column,1));
        RetailerD = string(zeros(Height_of_Column,1));
        for i = 1:Height_of_Column
            Price = ['a','b','c','d'];
            Entry_char_A = char(Grocery_store_dataset{i,5});
            Entry_char_B = char(Grocery_store_dataset{i,5});
            Entry_char_C = char(Grocery_store_dataset{i,5});
            Entry_char_D = char(Grocery_store_dataset{i,5});
            
            for j = 2:length(Entry_char_A)
                if (Entry_char_A(j)=='/') 
                    break;
                end
                Price(j-1) = Entry_char_A(j);
            end

             for j = 2:length(Entry_char_A)

                Numerical_price = str2double(Price);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RETAILER A
                random = rand();
                if(random>0.5) 
                    Numerical_price_A = Numerical_price + random + 0.00000001;
                else
                    Numerical_price_A = Numerical_price - random + 0.00000001;
                end
                if (Numerical_price_A < 0 )
                    Numerical_price_A = Numerical_price_A + 0.500000001;
                end
                Price_A = num2str (Numerical_price_A);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RETAILER B
                random = rand();
                if(random>0.5) 
                    Numerical_price_B = Numerical_price + random + 0.00000001;
                else
                    Numerical_price_B = Numerical_price - random + 0.00000001;
                end
                if (Numerical_price_B < 0 )
                    Numerical_price_B = Numerical_price_B + 0.500000001;
                end
                Price_B = num2str (Numerical_price_B);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RETAILER C
                random = rand();
                if(random>0.5) 
                    Numerical_price_C = Numerical_price + random + 0.00000001;
                else
                    Numerical_price_C = Numerical_price - random + 0.00000001;
                end
                if (Numerical_price_C < 0 )
                    Numerical_price_C = Numerical_price_C + 0.500000001;
                end
                Price_C = num2str (Numerical_price_C);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RETAILER D
                random = rand();
                if(random>0.5) 
                    Numerical_price_D = Numerical_price + random + 0.00000001;
                else
                    Numerical_price_D = Numerical_price - random + 0.00000001;
                end
                if (Numerical_price_D < 0 )
                    Numerical_price_D = Numerical_price_D + 0.500000001;
                end
                Price_D = num2str (Numerical_price_D);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                if (Entry_char_A(j)=='/') 
                    break;
                end
                if ((j-1)<=length(Price_A))
                    Entry_char_A(j) = Price_A(j-1);
                end
                if ((j-1)<=length(Price_B))
                    Entry_char_B(j) = Price_B(j-1);
                end
                if ((j-1)<=length(Price_C))
                    Entry_char_C(j) = Price_C(j-1);
                end
                if ((j-1)<=length(Price_D))
                    Entry_char_D(j) = Price_D(j-1);
                end        
                %Numerical_price = char(Grocery_store_dataset{4,j});
            end
            RetailerA(i) = string(Entry_char_A);
            RetailerB(i) = string(Entry_char_B);
            RetailerC(i) = string(Entry_char_C);
            RetailerD(i) = string(Entry_char_D);
        end

        Grocery_store_dataset.RetailerA = RetailerA;
        Grocery_store_dataset.RetailerB = RetailerB;
        Grocery_store_dataset.RetailerC = RetailerC;
        Grocery_store_dataset.RetailerD = RetailerD;

        
        %% 

        Response = input("Enter Keyword, model,specifications for your product\n",'s');
        disp("Getting list of Available Products...");
        Height_of_Column = height(Grocery_store_dataset.PricePerEach);
        Matched_indices =  zeros(Height_of_Column,1);
        j=1;
        for i=1: Height_of_Column

            % Name Searching
            Name = char(Grocery_store_dataset{i,2});
            Val_1 = contains(lower(Name),lower(Response));

            % Category Searching
            Category = char(Grocery_store_dataset{i,2});
            Val_2 = contains(lower(Category),lower(Response));    

            % Product ID Searching
            Product_ID = char(Grocery_store_dataset{i,2});
            Val_3 = contains(lower(Product_ID),lower(Response));    

            if(Val_1 == 1 || Val_2 == 1 || Val_3 == 1)
                Matched_indices(j) = i;
                j=j+1;
            end
            length_matched  = j-1;
        end
        %%
        Rows_to_Disp =  Matched_indices(1:length_matched);
        if (length_matched ~= 0)
        disp("Following are the available products" );
        disp("");
        Grocery_store_dataset(Rows_to_Disp,[1:7,10:15])
        else
        disp("No matching Products" );    
        end
        %%
        Opt = input("Do you want to select proucts For Price Alerts? 1 or 0",'s');
        if (Opt == '1')
            while(1)   
                Product = input("Enter Ser No of the prouct you want to get price alerts about",'s');
                if ((str2double(Product))>=1 && (str2double(Product))<=Height_of_Column)
                 Fav_Products(index) = str2double(Product);
                 index=index+1;
                 Opt = input("Do you want to select another prouct? 1 or 0",'s');
                 switch (Opt)
                     case '1'
                         continue;
                     otherwise
                         break;
                 end
                else
                    disp("Invalid Entry, Kindly Re-enter" ); 
                    continue;
                end
            end
        end
        disp("Your Favourite Products Record has been updated");
    elseif (Option == '2')
        if (Fav_Products(1) == 0)
            disp("No Favourite Product Alerts Set");
        else
            Rows_to_Disp =  Fav_Products(1:index-1);
            disp("The current prices of your favourite products are," );  
            Grocery_store_dataset(Rows_to_Disp,[1:7,10:15])
        end
        continue;    
    elseif (Option == '3')
        if (Fav_Products(1) == 0)
            disp("No Favourite Product Alerts Set For Feedback");
        else
            Rows_to_Disp =  Fav_Products(1:index-1);
            disp("The current prices of your favourite products are," );  
            Grocery_store_dataset(Rows_to_Disp,[1:7,10:15])
            while(1)
                Serial_Number = input("Enter Serial No of Product for Feedback",'s');
                Serial_Number_double = str2double (Serial_Number);
                if (Serial_Number_double>=1 && Serial_Number_double<=Height_of_Column)
                ProductFeedback = input("Give Feedback from 1 to 5",'s');
                ProductFeedback_double = str2double(ProductFeedback);
                if (ProductFeedback_double>=1 && ProductFeedback_double<=5)
                    old_feeback = (Grocery_store_dataset{Serial_Number_double,11});
                    val = (old_feeback + ProductFeedback_double)/2.0;
                    Grocery_store_dataset{Serial_Number_double,11} = string(val);
                else
                    disp("Invalid Entry");    
                    break;
                end
                end
                
                Opt = input("Do you want to give another Feedback? 1 or 0",'s');
                switch (Opt)
                    case '1' 
                        continue;
                    otherwise
                        break;
                end
            end
        end
        continue;               
    elseif (Option == '4')
        break; 
    end

end